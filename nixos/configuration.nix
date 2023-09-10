# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  #  # bash script to let dbus know about important env variables and
  # propagate them to relevent services run at the end of sway config
  # see
  # https://github.com/emersion/xdg-desktop-portal-wlr/wiki/"It-doesn't-work"-Troubleshooting-Checklist
  # note: this is pretty much the same as  /etc/sway/config.d/nixos.conf but also restarts  
  # some user services to make sure they have the correct environment variables
  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-environment";
    executable = true;

    text = ''
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
      systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
      systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
    '';
  };

  # currently, there is some friction between sway and gtk:
  # https://github.com/swaywm/sway/wiki/GTK-3-settings-on-Wayland
  # the suggested way to set gtk settings is with gsettings
  # for gsettings to work, we need to tell it where the schemas are
  # using the XDG_DATA_DIR environment variable
  # run at the end of sway config
  configure-gtk = pkgs.writeTextFile {
    name = "configure-gtk";
    destination = "/bin/configure-gtk";
    executable = true;
    text = let
      schema = pkgs.gsettings-desktop-schemas;
      datadir = "${schema}/share/gsettings-schemas/${schema.name}";
    in ''
      export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
      gnome_schema=org.gnome.desktop.interface
      gsettings set $gnome_schema gtk-theme 'Dracula'
    '';
  };

  #wrapper for python to inject NIX_LD_LIBRARY_PATH
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
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    nvidia = {
      # Modesetting is required.
      modesetting.enable = true;

      # Enable power management (do not disable this unless you have a reason to).
      # Likely to cause problems on laptops and with screen tearing if disabled.
      powerManagement.enable = true;

      # Use the NVidia open source kernel module (not to be confused with the
      # independent third-party "nouveau" open source driver).
      # Support is limited to the Turing and later architectures. Full list of 
      # supported GPUs is at: 
      # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
      # Only available from driver 515.43.04+
      # Do not disable this unless your GPU is unsupported or if you have a good reason to.
      open = true;

      # Enable the Nvidia settings menu,
      # accessible via `nvidia-settings`.
      nvidiaSettings = true;

      # Optionally, you may need to select the appropriate driver version for your specific GPU.
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
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

    # wayland essentials
    wayland
    swayidle # idle counter
    swaylock # locking
    kanshi # monitor
    wdisplays # monitor manager
    wl-clipboard # clipboard

    rofi-wayland # menu
    networkmanagerapplet # nm-applet
    blueman # bluetooth manager gui
    pavucontrol # pulse-audio gui
    pamixer # pulse-audio cli
    mako # notification
    flameshot # screenshot
    swaybg # desktop bg

    # sway
    dbus-sway-environment 
    xdg-utils # opening default programs using links
    glib # gsettings
    dracula-theme # dracula theme
    gnome3.adwaita-icon-theme # default gnome icons
    configure-gtk  # configure dracula theme
    #eww-wayland
    waybar

    # utility
    brave
    spotify
    obsidian
    obs-studio
    libreoffice
    vlc

    # chat apps
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

    # languages
    python311
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
    patchelf # patch elf binaries
    zlib # zlib
    fuse3 # fuse
    fuse # fuse
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
      videoDrivers = ["nvidia"];
    };

    dbus = {
      enable = true;
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };

    blueman.enable = true; 
    gvfs.enable = true; # thunar - Mount, trash, and other functionalities
    tumbler.enable = true; # thunar - Thumbnail support for images

    tailscale.enable = true;                                       
    flatpak.enable = true;                                        

  };

  # xdg-desktop-portal works by exposing a series of D-Bus interfaces
  # known as portals under a well-known name
  # (org.freedesktop.portal.Desktop) and object path
  # (/org/freedesktop/portal/desktop).
  # The portal interfaces include APIs for file access, opening URIs,
  # printing and others.
  xdg = {
    portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [ 
        pkgs.xdg-desktop-portal-gtk # thunar
      ];
      gtkUsePortal = true;
    };
  };

  # Programs
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs = {
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

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    light = {
      enable = true;
    };

    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };

    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };

  };

  # Fonts
  fonts = {
    fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "Hack" ]; })
      # sway fonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      font-awesome
      source-han-sans
      source-han-sans-japanese
      source-han-serif-japanese
    ];
    # sway fonts
    fontconfig.defaultFonts = {
      serif = [ "Noto Serif" "Source Han Serif" ];
      sansSerif = [ "Noto Sans" "Source Han Sans" ];
    };
  };

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
