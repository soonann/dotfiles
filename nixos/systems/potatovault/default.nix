# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  # .bashrc

  # .vimrc 
in
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # ../../modules/services/syncthing/potatovault.nix
      ../../modules/services/traefik
      #../../modules/services/authelia
      ../../modules/containers
      ../../modules/zfs
      ../../modules/virtualisation
      #./k3s
    ];

  # Bootloader. - default settings
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # xfs support
  boot.kernelModules = [ "xfs" ];
  boot.supportedFilesystems = [ "xfs" ];


  # Set your time zone.
  time.timeZone = "Asia/Singapore";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_SG.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_SG.UTF-8";
    LC_IDENTIFICATION = "en_SG.UTF-8";
    LC_MEASUREMENT = "en_SG.UTF-8";
    LC_MONETARY = "en_SG.UTF-8";
    LC_NAME = "en_SG.UTF-8";
    LC_NUMERIC = "en_SG.UTF-8";
    LC_PAPER = "en_SG.UTF-8";
    LC_TELEPHONE = "en_SG.UTF-8";
    LC_TIME = "en_SG.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    soonann = {
      isNormalUser = true;
      description = "soonann";
      extraGroups = [ "networkmanager" "wheel" "nextcloud" ];
      packages = with pkgs; [ ];
    };

    nextcloud = {
      isSystemUser = true;
      uid = 999;
      group = "nextcloud";
    };
  };

  users.groups = {
    nextcloud = {
      gid = 999;
    };
  };

  # basic networking settings
  networking = {
    hostName = "potatovault"; # Define your hostname
    #useDHCP = false;
    #interfaces = {
    #  enp2s0.ipv4.addresses = [
    #    {
    #      address = "192.168.0.199";
    #      prefixLength = 24;
    #    }
    #  ];
    #};
    #defaultGateway = "192.168.0.1";
    #nameservers = [ "192.168.0.1" ];
  };

  networking.hostId = "f839bdb9";

  security.sudo.extraConfig = ''
    Defaults        timestamp_timeout=30
  '';

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.extraOptions = ''
    plugin-files = ${pkgs.nix-plugins}/lib/nix/plugins
  '';

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    coreutils
    busybox
    smartmontools
    vim
    tmux
    tmate
    htop
    btop
    pv
    tailscale
    git
  ];

  services.tailscale = {
    enable = true;
    extraUpFlags = [
      "--ssh"
      "--advertise-exit-node"
    ];
    useRoutingFeatures = "server";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  systemd.extraConfig = ''
    DefaultTimeoutStopSec=90s
  '';

  # import pool on boot
  boot.zfs.extraPools = [ "potatopool" "cachepool" ];

  # sanoid
  services.sanoid = {
    enable = true;
    package = pkgs.sanoid;
    templates = {
      "prod" = {
        monthly = 2;
        daily = 30;
        autoprune = true;
        autosnap = true;
      };
    };
    datasets = {
      "potatopool/data" = {
        use_template = [ "prod" ];
        recursive = true;
      };
      "potatopool/local" = {
        use_template = [ "prod" ];
        recursive = true;
      };
      "potatopool/unraid" = {
        use_template = [ "prod" ];
        recursive = true;
      };
      "cachepool/secrets" = {
        use_template = [ "prod" ];
        recursive = true;
      };
      "cachepool/appdata" = {
        use_template = [ "prod" ];
        recursive = true;
      };
    };
  };

  # env variables
  environment.sessionVariables = rec { };

}
