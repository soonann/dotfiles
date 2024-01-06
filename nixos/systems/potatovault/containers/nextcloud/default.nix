{pkgs, config, lib, ...}:{

  # nextcloud container definition
  containers.nextcloud = {
    autoStart = true;
    privateNetwork = true;
    hostAddress = "10.0.0.10";
    localAddress = "10.0.0.11";
    config = { config, pkgs, ... }: {

      system.stateVersion = "23.11";

      # nextcloud service
      services.nextcloud = {
        enable = true;
        package = pkgs.nextcloud28;
        hostName = "localhost";
        config.adminpassFile = "${pkgs.writeText "adminpass" "test123"}"; # DON'T DO THIS IN PRODUCTION - the password file will be world-readable in the Nix Store!
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
