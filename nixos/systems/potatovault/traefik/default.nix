{pkgs, config, lib, ...}:{

    networking = {
      firewall = {
        enable = true;
        #allowedTCPPorts = [ 80 443 ];
      };
    };

    services.traefik = {
      enable = true;
      package = pkgs.traefik;

      # static config
      staticConfigOptions = {

        # disable telemetry
        global = {
          checkNewVersion = false;
          sendAnonymousUsage = false;
        };

        # entrypoints
        entryPoints = {
          # http entrypoint
          web = {
            address = ":80";
            #http.redirections.entrypoint = {
              #  to = "websecure";
              #  scheme = "https";
              #};
          };
          # https entrypoint
          websecure = {
            address = ":443";
          };
        };


        # dynamic config
        dynamicConfigOptions = {

          # tls config
          #tls = {
            #  stores.default = {
              #    defaultCertificate = {
                #      certFile = "/var/lib/acme/domain.com/cert.pem";
                #      keyFile = "/var/lib/acme/domain.com/key.pem";
                #    };
              #  };

            #  certificates = [
            #  {
              #    certFile = "/var/lib/acme/domain.com/cert.pem";
              #    keyFile = "/var/lib/acme/domain.com/key.pem";
              #    stores = "default";
              #  }
            #  ];
            #};

          # router config
          http.routers.nextcloud = {
            entryPoints = [ "web" "websecure" ];
            rule = "Host(`cloud.soonann.dev`)";
            service = "nextcloud";
            #tls = {
              #  certResolver = "my-resolver";
              #  domains = {
                #    main = [ "domain.com" ];
                #    sans = [ "*.domain.com" ];
                #  };
              #};
          };

          # service config
          http.services.nextcloud = {
            loadBalancer.servers = [{
              url = "http://nextcloud.containers:80";
            }];
          };
        };

        # make it so traefik.enable = true label needs to be set before exposed
        providers.docker.exposedByDefault = false;

      };
    };
}
