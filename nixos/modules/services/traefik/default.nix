{pkgs, config, lib, ...}:{

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [ 80 443 8080 ];
    };
  };

  # traefik configs
  services.traefik = {
    enable = true;
    package = pkgs.traefik;
    group = "docker";
    dataDir = "/run/appdata/traefik";
    environmentFiles = [
      "/run/secrets/traefik/.env"
    ];

    # static config
    staticConfigOptions = {
      global = {
        checkNewVersion = false;
        sendAnonymousUsage = false;
      };
      api = {
        dashboard = true;
        insecure = true;
      };

      # entrypoints
      entryPoints = {
        web = {
          address = ":80";
          http.redirections.entrypoint = {
            to = "websecure";
            scheme = "https";
          };
        };
        websecure = {
          address = ":443";
        };
      };
	
      # cert resolvers
      certificatesResolvers = {
        cloudflare = {
          acme = {
            email = "sudo@soonann.dev";
	    storage = "/run/secrets/traefik/acme.json";
            dnsChallenge = {
		provider = "cloudflare";
		resolvers = [
		  "1.1.1.1:53"
		  "1.0.0.1:53"
		];
	    };
          };
        };
      };
    };

    # dynamic config
    dynamicConfigOptions = {

      # routers
      http = {
	routers = {
          vaultwarden = {
            rule = "Host(`vaultwarden.soonann.dev`) && !Path(`/admin`)";
            service = "vaultwarden";
	    entrypoints = [ "websecure" ];
            tls = {
              certResolver = "cloudflare";
            };
          };
          nextcloud = {
            rule = "Host(`cloud.soonann.dev`)";
            service = "nextcloud";
	    entrypoints = [ "websecure" ];
            tls = {
              certResolver = "cloudflare";
            };
          };
          linkding = {
            rule = "Host(`linkding.soonann.dev`)";
            service = "linkding";
	    entrypoints = [ "websecure" ];
            tls = {
              certResolver = "cloudflare";
            };
          };

	};
      };

      # services
      http.services = {

        vaultwarden = {
          loadBalancer =  {
            servers = [
              { url = "http://vaultwarden:80"; }
            ];
          };
        };

        linkding = {
          loadBalancer =  {
            servers = [
              { url = "http://localhost:9090"; }
            ];
          };
        };

        nextcloud = {
          loadBalancer =  {
            servers = [
              { url = "http://nextcloud:80"; }
            ];
          };
        };


      };

      # require docker labels before exposed
      providers.docker.exposedByDefault = false;
    };

  };

}
