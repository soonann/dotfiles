{pkgs, config, lib, ...}:
  let
    domain = "soonann.dev"; 
    stateDir = "/srv/gitea";
  in
{
  # create user gitea
  users.groups.gitea = {};
  users.users.gitea = {
    isSystemUser = true;
    group = "gitea";
  };

  # gitea container
  containers.gitea = {
    ephemeral = true;
    autoStart = true;
    privateNetwork = true;
    hostBridge = "br0";
    localAddress = "10.0.0.30/24";
    bindMounts = { 
      "/srv/gitea" = { 
        hostPath = "/run/appdata/gitea";
        isReadOnly = false; 
      };
    };

    # container nixos config
    config = { config, pkgs, ... }: {
      services.gitea = {
        enable = true;
        rootUrl = "https://git.${domain}/";
        appName = "Gitea";
        disableRegistration = true;
        stateDir = stateDir;
        repositoryRoot = "${stateDir}/repositories";
        database = {
          type = "sqlite3";
          path = "${stateDir}/gitea.db";
        };
        lfs = {
          enable = true;
          contentDir = "${stateDir}/lfs";
        };
        log.rootPath = "${stateDir}/log";
        enableUnixSocket = true;
        cookieSecure = true;
        settings = {
          server = {
            OFFLINE_MODE = true;
          };

        };

      };

      system.stateVersion = "23.11";
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
