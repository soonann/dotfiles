{pkgs, config, lib, ...}:
  let
    # nextcloud admin password file
    nextcloud_host_adminpass = "/run/secrets/nextcloud/adminpass";
    nextcloud_container_adminpass = "/run/secrets/adminpass";

    # nextcloud appdata dir
    nextcloud_host_data = "/run/appdata/nextcloud";
    nextcloud_container_data = "/var/lib/nextcloud";
    
    # pg appdata dir
    pgsql_host_data = "/run/appdata/nextcloud-pgsql";
    pgsql_container_data = "/var/lib/postgresql/15";

    # soonann data dir
    soonann_host_data = "/potatopool/data/soonann";
    soonann_container_data = "/var/lib/nextcloud/data/soonann/files";

    # zion data dir
    zion_host_data = "/potatopool/data/zion";
    zion_container_data = "/var/lib/nextcloud/data/zion/files";
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
      "${soonann_container_data}" = { 
        hostPath = soonann_host_data;
        isReadOnly = false;
      };
      "${zion_container_data}" = { 
        hostPath = zion_host_data;
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

	extraAppsEnable = true;
	extraApps = {
	  inherit (config.services.nextcloud.package.packages.apps) contacts; 
	};

	# extraOptions
	# https://docs.nextcloud.com/server/latest/admin_manual/configuration_server/config_sample_php_parameters.html#filesystem-check-changes
	# https://search.nixos.org/options?channel=23.11&show=services.nextcloud.extraOptions&from=0&size=50&sort=relevance&type=packages&query=services.nextcloud
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
