{pkgs, config, lib, ...}:
  let 
    # persistence
    container_data_dir = "/var/lib/bitwarden_rs";
    host_data_dir = "/potatopool/appdata/vaultwarden";

    # env variables
    container_env_file = "/var/lib/vaultwarden.env";
    host_env_file = "/potatopool/secrets/vaultwarden/vaultwarden.env";

  in
{
  # vaultwarden container
  containers.vaultwarden = {
    ephemeral = true;
    autoStart = true;
    privateNetwork = true;
    hostAddress = "10.0.0.10";
    localAddress = "10.0.0.11";
    bindMounts = { 
      "${container_env_file}" = { 
        hostPath = host_env_file;
        isReadOnly = false;
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
      services.vaultwarden = {
        enable = true;
        backupDir = "${host_data_dir}/backup";
        environmentFile = container_env_file;
        config = {
          DOMAIN = "https://bitwarden.soonann.dev";
          SIGNUPS_ALLOWED = false;
          ROCKET_ADDRESS = "0.0.0.0";
          ROCKET_PORT = 80;
          ROCKET_LOG = "critical";
        };
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
