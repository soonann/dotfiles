# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  # wrapper for python to inject NIX_LD_LIBRARY_PATH
  #pyLdWrapper = pkgs.writeShellScriptBin "python" ''
    #export LD_LIBRARY_PATH=$NIX_LD_LIBRARY_PATH
    #exec ${pkgs.python311}/bin/python "$@"
  #'';
in {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./hosts.nix
    ];

  # boot
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  # Networking
  networking = {
    hostName = "nixos"; # Define your hostname.
    networkmanager.enable = true; # Enable networking
    #wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    #proxy.default = "http://user:password@proxy:port/";
    #proxy.noProxy = "127.0.0.1,localhost,internal.domain"; 
    # Open ports in the firewall.
    #firewall.allowedTCPPorts = [ ... ];
    #firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    #firewall.enable = false;
  };

  # Hardware
  hardware = {
    bluetooth.enable = true;
    opengl.enable = true;
    nvidia.modesetting.enable = true;
  };

  # Time/Locale
  time.timeZone = "Asia/Singapore";
  i18n = {
    defaultLocale = "en_SG.UTF-8";
    extraLocaleSettings = {
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
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # Users
  users.users.soonann = {
    isNormalUser = true;
    description = "Soon Ann";
    extraGroups = [ "networkmanager" "wheel" "video" "docker" "libvirtd" ];
    packages = with pkgs; [];
  };

  # Nixpkgs/Nix
  nixpkgs.config.allowUnfree = true;
  nix = {
    settings.experimental-features = "nix-command flakes";
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

    # sway
    #dbus-sway-environment
    #configure-gtk
    #wayland
    #xdg-utils
    #glib
    #dracula-theme
    #gnome3.adwaita-icon-theme
    #swayidle
    #swaylock
    #grim
    #slurp
    #wl-clipboard
    #bemenu
    #rofi
    #mako
    #wdisplays
    #waybar
    #blueman
    #flameshot
    #kanshi
    #gparted

    # wayland essentials
    rofi-wayland # dmenu
    wl-clipboard # clipboard
    mako # notification
    flameshot # screenshot
    kanshi # monitor
    networkmanagerapplet # nm-applet
    blueman # bluetooth manager gui
    pavucontrol # pulse-audio gui
    pamixer # pulse-audio cli

    # hyprland
    eww-wayland # status bar
    swww # background

    # utility
    brave
    spotify
    obsidian
    obs-studio
    libreoffice
    vlc

    # chat apps
    discord    
    slack
    zoom-us

    # file exporer
    xfce.thunar-volman
    xfce.thunar-archive-plugin
    xarchiver
    gvfs

    # libs
    ffmpeg
    libsecret

    # networking
    tailscale

    # flatpak
    flatpak
    gnome.gnome-software

    # development
    vim
    alacritty
    tmux
    neovim
    android-studio

    # cli tools
    git
    kubectl
    curl
    wget
    rclone
    dos2unix
    appimage-run
    neofetch
    
    # fs
    btrfs-progs
    pinentry
    file
    gnupg
    gnumake

    # cli tools
    htop # cpu/mem top
    nvtop # gpu top
    lsof # open files
    pciutils # lspci - pci devices
    zip # archives
    unzip 
    acpi # battery

    ripgrep
    fd 
    fzf
    jq # json parsing
    socat
    coreutils-full # gnu utils

    # containers
    docker-compose
    #k3s
    #ipset

    # languages
    python311
    #(python311.withPackages(ps: with ps; [ virtualenv ]))
    go
    jdk17
    rustup
    cargo

    nodejs
    flutter
    virt-manager 

    # keyring
    #gnome.seahorse
    #gnome.gnome-keyring
    #thunderbird
    #evolution
    #evolution-ews
    #protonmail-bridge

    # elf
    nix-index # nix-locate
    patchelf
    zlib 
    fuse3
    fuse
    stdenv.cc.cc
    gcc_multi
    glibc
    gdb

  ];

  security.polkit.enable = true;
  virtualisation = {
    libvirtd.enable = true;

    docker.enable = true;
    docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };

  };

  # List services that you want to enable:
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  services = {

    # Configure keymap in X11
    xserver = {
      layout = "us";
      xkbVariant = "";
    };

    dbus = {
      enable = true;
      packages = with pkgs; [
        xfce.xfconf
      ];
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };

    blueman.enable = true; 
    gvfs.enable = true; # thunar - Mount, trash, and other functionalities
    tumbler.enable = true; # thunar - Thumbnail support for images

    #gnome = {
      #gnome-keyring.enable = true;
    #};

    tailscale.enable = true;                                       
    flatpak.enable = true;                                        

  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = [ 
        pkgs.xdg-desktop-portal-gtk # thunar
        #pkgs.xdg-desktop-portal-hyprland
      ];
    };
  };




  #services.k3s.enable = true;
  #services.k3s.role = "server";
  #services.k3s.extraFlags = toString [
    # "--kubelet-arg=v=4" # Optionally add additional args to k3s
  #];

  #systemd.services.k3s.path = [ pkgs.ipset ];
  #systemd.user.services.protonmail-bridge = {
  #  wantedBy = [ "default.target" ]; 
  #  after = [ "network.target" ];
  #  description = "Protonmail Bridge";
  #  serviceConfig = {
  #    Restart = "always";
  #    ExecStart = "${pkgs.protonmail-bridge}/bin/protonmail-bridge -n";         
  #  };
  #};

  # Programs
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;

  #programs.sway = {
    #enable = true;
    #wrapperFeatures.gtk = true;
  #};
  
  programs = {

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    nix-ld = {
      enable = true;
      libraries = with pkgs; [
         stdenv.cc.cc

         # flatpak
         zlib # zlib.so
         fuse # fuse.so.2
         fuse3 
      ];
    };

    hyprland = {
      enable = true;
      nvidiaPatches = true;
      xwayland.enable = true;
    };

    light = {
      enable = true;
    };

    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
          thunar-volman
      ];
    };

    #dconf.enable = true;
    #seahorse.enable = true;
    #evolution = {
      #enable = true;
      #plugins = [ pkgs.evolution-ews ];
    #};

  };

  # Fonts
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "Hack" ]; })
  ];

  # Environment
  environment = {

    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
