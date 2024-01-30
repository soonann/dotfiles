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
      certificatesResolvers = {
        soonann-dev-resolver = {
          acme = {
            email = "sudo@soonann.dev";
            tlsChallenge = {};
          };
        };
      };
    };

    # dynamic config
    dynamicConfigOptions = {

      # routers
      http.routers = {

        vaultwarden = {
          rule = "Host(`vaultwarden.soonann.dev`) && !Path(`/admin`)";
          service = "vaultwarden";
          tls = {
            certResolver = "soonann-dev-resolver";
            domains = {
              main = [ "vaultwarden.soonann.dev" ];
            };
          };
        };

        nextcloud = {
          rule = "Host(`cloud.soonann.dev`)";
          service = "nextcloud";
          tls = {
            certResolver = "soonann-dev-resolver";
            domains = {
              main = [ "cloud.soonann.dev" ];
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
