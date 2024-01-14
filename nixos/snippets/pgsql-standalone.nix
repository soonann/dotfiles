{pkgs, config, lib, ...}:
  let
    # nextcloud admin password file
    nextcloud_host_adminpass = "/potatopool/secrets/nextcloud/adminpass";
    nextcloud_container_adminpass = "/run/secrets/adminpass";

    # nextcloud data dir
    nextcloud_host_data = "/potatopool/appdata/nextcloud";
    nextcloud_container_data = "/var/lib/nextcloud";
    
    # pg db password file
    pgsql_host_dbpass = "/potatopool/secrets/nextcloud/pgsql/dbpass";
    pgsql_container_dbpass = "/run/secrets/dbpass";

    # pg data dir
    pgsql_host_data = "/potatopool/appdata/nextcloud-pgsql";
    pgsql_container_data = "/var/lib/postgresql/15";
  in
{
  containers.pgsql-nextcloud = {
    
    autoStart = true;
    ephemeral = true;
    privateNetwork = true;
    hostBridge = "br0";
    localAddress = "10.0.0.21/24";
    bindMounts = {
      # secrets
      "${pgsql_container_dbpass}" = { 
        hostPath = pgsql_host_dbpass;
        isReadOnly = true; 
      };

      # data
      "${pgsql_container_data}" = { 
        hostPath = pgsql_host_data;
        isReadOnly = false;
      };
    };

    config = { config, pkgs, ... }: {

      system.stateVersion = "23.11";

      # pgsql service
      services.postgresql = {
        enable = true;
        port = 5432;
        package = pkgs.postgresql_15;
        dataDir = pgsql_container_data;
        #ensureUsers = [
        #  { name = "nextcloud"; }
        #];
        #ensureDatabases = [
        #  "nextcloud"
        #];
        authentication = pkgs.lib.mkOverride 10 ''
          #...
          #type database DBuser origin-address auth-method
          # ipv4
          local all      all     trust
	  host  all      all     127.0.0.1/32   trust
          host  all      all     0.0.0.0/0   trust
          '';
        initialScript = pkgs.writeText "backend-initScript" ''
	  CREATE ROLE nextcloud WITH LOGIN PASSWORD 'nextcloud' CREATEDB;
	  CREATE DATABASE nextcloud;
	  GRANT ALL PRIVILEGES ON DATABASE nextcloud TO nextcloud;
        '';
      };

      networking = {
        firewall = {
          enable = true;
          allowedTCPPorts = [ 5432 ];
        };
        # Use systemd-resolved inside the container
        # Workaround for bug https://github.com/NixOS/nixpkgs/issues/162686
        useHostResolvConf = lib.mkForce false;
      };

      services.resolved.enable = true;

    };
  };

  # nextcloud container
  containers.nextcloud = {
    ephemeral = true;
    autoStart = true;
    privateNetwork = true;
    hostBridge = "br0";
    localAddress = "10.0.0.20/24";
    bindMounts = { 
      # secrets
      "${pgsql_container_dbpass}" = { 
        hostPath = pgsql_host_dbpass;
        isReadOnly = true; 
      };
      "${nextcloud_container_adminpass}" = { 
        hostPath = nextcloud_host_adminpass;
        isReadOnly = true; 
      };

      # data
      "${nextcloud_container_data}" = { 
        hostPath = nextcloud_host_data;
        isReadOnly = false;
      };
    };

    # container nixos config
    config = { config, pkgs, ... }: {

      system.stateVersion = "23.11";
      environment.etc."nextcloud-db-pass".text = "nextcloud";

      # nextcloud service
      services.nextcloud = {
        enable = true;
        package = pkgs.nextcloud28;
        hostName = "cloud.soonann.dev";
        home = nextcloud_container_data;
        config.adminuser = "soonann";
        config.adminpassFile = nextcloud_container_adminpass;
        config.trustedProxies = [
          "10.0.0.10"
        ];
        config.extraTrustedDomains = [
        ];

        # pgsql config for nextcloud
        config.dbtype = "pgsql";
        config.dbhost = "10.0.0.21";
        config.dbname = "nextcloud";
        config.dbuser = "nextcloud";
        #config.dbpassFile = pgsql_container_dbpass;
        config.dbpassFile = "/etc/nextcloud-db-pass";
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
