{pkgs, config, lib, ...}:
  let
    # nextcloud admin password file
    nextcloud_host_adminpass = "/potatopool/secrets/nextcloud/adminpass";
    nextcloud_container_adminpass = "/run/secrets/adminpass";

    # nextcloud data dir
    nextcloud_host_data = "/potatopool/appdata/nextcloud";
    nextcloud_container_data = "/var/lib/nextcloud";
    
    # pg data dir
    pgsql_host_data = "/potatopool/appdata/nextcloud-pgsql";
    pgsql_container_data = "/var/lib/postgresql/15";
  in
{

  # nextcloud container
  containers.nextcloud = {
    ephemeral = true;
    autoStart = true;
    privateNetwork = true;
    hostBridge = "br0";
    localAddress = "10.0.0.20/24";
    bindMounts = { 
      "${nextcloud_container_adminpass}" = { 
        hostPath = nextcloud_host_adminpass;
        isReadOnly = true; 
      };

      # data
      "${pgsql_container_data}" = { 
        hostPath = pgsql_host_data;
        isReadOnly = false; 
      };
      "${nextcloud_container_data}" = { 
        hostPath = nextcloud_host_data;
        isReadOnly = false;
      };
    };

    # container nixos config
    config = { config, pkgs, ... }: {

      system.stateVersion = "23.11";

      # nextcloud service
      services.nextcloud = {
        enable = true;
        package = pkgs.nextcloud28;
        hostName = "cloud.soonann.dev";
        home = nextcloud_container_data;

        # proxy/domains
        config.trustedProxies = [
          "10.0.0.10"
        ];

        config.extraTrustedDomains = [
        ];
        # admin user
        config.adminuser = "soonann";
        config.adminpassFile = nextcloud_container_adminpass;

        # db config
        config.dbtype = "pgsql";
        config.dbhost = "/run/postgresql";
        config.dbname = "nextcloud";
        config.dbuser = "nextcloud";
      };

      # postgresql for nextcloud
      services.postgresql = {
        enable = true;
	package = pkgs.postgresql_15;
	dataDir = pgsql_container_data;
        ensureDatabases = [ "nextcloud" ];
        ensureUsers = [
        { 
          name = "nextcloud";
          ensureDBOwnership = true;
        }
        ];
	#initialScript = pgsql_container_initScript;
      };

      # map dependencies of nextcloud with systemd 
      systemd.services."nextcloud-setup" = {
        requires = ["postgresql.service"];
        after = ["postgresql.service"];
      };


      networking = {
        firewall = {
          enable = true;
          allowedTCPPorts = [ 80 ];
        };
        # Use systemd-resolved inside the container
        # Workaround for bug https://github.com/NixOS/nixpkgs/issues/162686
        useHostResolvConf = lib.mkForce false;
      };

      services.resolved.enable = true;

    };
  };

}
