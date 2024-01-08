{pkgs, config, lib, ...}:
  let
    # admin password file
    host_adminpass_file = "/potatopool/secrets/nextcloud/pgsql/adminpass";
    container_adminpass_file = "/run/secrets/adminpass";
    
    # db password file
    host_dbpass_file = "/potatopool/secrets/nextcloud/dbpass";
    container_dbpass_file = "/run/secrets/dbpass";

    # data dir
    host_data_dir = "/potatopool/appdata/nextcloud";
    container_data_dir = "/var/lib/nextcloud";
  in
{
  #container.postgreqsl = {
  #  ephemeral = true;
  #  autostart = true;
  #  privateNetwork = true;
  #  hostAddress = "10.0.0.10";
  #  localAddress = "10.0.0.11";
  #  bindMounts = {
  #  };
  #};

  # nextcloud container
  containers.nextcloud = {
    ephemeral = true;
    autoStart = true;
    privateNetwork = true;
    hostAddress = "10.0.0.10";
    localAddress = "10.0.0.20";
    bindMounts = { 
      "${container_adminpass_file}" = { 
        hostPath = host_adminpass_file;
        isReadOnly = true; 
      };
      "${container_dbpass_file}" = { 
        hostPath = host_dbpass_file;
        isReadOnly = true; 
      };
      "${container_data_dir}" = { 
        hostPath = host_data_dir;
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
        home = container_data_dir;
        config.adminuser = "soonann";
        config.adminpassFile = container_adminpass_file;
        config.dbtype = "pgsql";
        config.dbhost = "nextcloud-pgsql";
        config.dbname = "nextcloud";
        config.dbuser = "nextcloud";
        config.dbpassFile = container_dbpass_file;
        config.trustedProxies = [
          "10.0.0.10"
        ];
        config.extraTrustedDomains = [
        ];
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
