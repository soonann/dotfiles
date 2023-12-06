# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  custom-python-pkgs = ps: with ps; [
    flake8
    python-lsp-server
  ];
  custom-python311 = pkgs.python3.withPackages custom-python-pkgs;
in
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

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


  xdg = {
    portal = {
      enable = true;
    };
  };


  # Enable sound with pipewire.
  sound.enable = true;
  hardware = {
    bluetooth.enable = true;
    bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
    pulseaudio.enable = false;
  };
  security.rtkit.enable = true; # gnome-defaults
  security.polkit.enable = true; # polkit for i3
  security.pam.services.login.enableGnomeKeyring = true; # using i3 with gkr
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # greenclip clipboard
  services.greenclip.enable = true;

  services.gnome.gnome-keyring.enable = true;

  services.dbus = {
    enable = true;
    packages = [
      pkgs.gnome.gnome-keyring
    ];
  };

  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  services.blueman.enable = true;
  services.gvfs.enable = true; # thunar - Mount, trash, and other functionalities
  services.tumbler.enable = true; # thunar - Thumbnail support for images

  services.tailscale.enable = true;
  services.flatpak.enable = true;

  # Configure keymap in X11
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";

    # Enable the i3 Desktop Environment.
    desktopManager = {
      xterm.enable = false;
    };
    displayManager = {
      defaultSession = "none+i3";
      #lightdm.enable = true;
    };
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu #application launcher most people use
        i3status # gives you the default i3 status bar
        i3lock #default i3 screen locker
        i3blocks #if you are planning on using i3blocks over i3status
      ];
      extraSessionCommands = ''
        eval $(gnome-keyring-daemon --daemonize)
        export SSH_AUTH_SOCK
      '';
    };

    # Enable the GNOME Desktop Environment.
    #displayManager.gdm.enable = true;
    #desktopManager.gnome.enable = true;

  };


  services.pipewire = { };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.soonann = {
    isNormalUser = true;
    description = "Soon Ann";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "docker"
      "libvirtd"
      "libvirt"
      "kvm"
      "dialout" # writing to /dev/ttyACM0
    ];
    packages = with pkgs; [
      #  firefox
      #  thunderbird
    ];
  };

  nixpkgs = {
    # Allow unfree packages
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "electron-24.8.6"
      ];
    };
  };

  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    #gc = {
    #automatic = true;
    #dates = "weekly";
    #options = "--delete-older-than 7d";
    #};
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

    #blueman # bluetooth manager gui
    pavucontrol # pulse-audio gui
    pamixer # pulse-audio cli
    flameshot # screenshot -> broken :(
    lxappearance # themes and icons
    arandr # display mgmt
    rofi # app menu
    polybarFull # status bar
    libgestures # trackpad gestures
    zfs # for zfs support

    xdg-utils # opening default programs using links
    glib # gsettings

    # utility
    google-chrome
    brave
    telegram-desktop
    slack
    firefox
    spotify
    obsidian
    obs-studio
    vlc # video/audio player
    feh # image viewer
    evince # pdf viewer
    virt-manager # vm gui

    # file exporer
    xfce.thunar-volman
    xfce.thunar-archive-plugin
    gnome.file-roller

    # libs
    ffmpeg

    # networking
    tailscale

    # flatpak
    flatpak
    gnome.gnome-software

    # gui apps
    thunderbird
    zoom-us
    discord
    onlyoffice-bin
    libreoffice
    gnome.gnome-calculator
    xournalpp

    # editing
    gimp

    # 3d printing
    cura

    # containers
    docker-compose
    nerdctl
    kubectl
    argocd
    act
    tmate # tmux sharing

    # languages/frameworks/pkg-manager
    custom-python311
    go
    jdk17
    gcc_multi
    gdb
    nodejs
    yarn
    flutter
    rustup
    nasm

    # cope
    vscode

    # iac
    ansible
    awscli2
    (google-cloud-sdk.withExtraComponents [ google-cloud-sdk.components.gke-gcloud-auth-plugin ])
    terraform
    terraform-lsp

    # ops
    vault
    certbot

    # development
    vim
    neovim
    alacritty
    tmux
    scrcpy
    gradle_7
    k6
    mongosh
    mongodb-compass

    # kubernetes
    minikube
    kind
    kubectl
    kubernetes-helm
    telepresence2
    tilt
    devspace
    helmfile
    #dagger

    # fs
    btrfs-progs

    # gpg
    gnupg
    pinentry # for the gpg to prompt

    # libs
    #set-libs
    #nix-index # nix-locate
    appimage-run # run app images
    patchelf # patch elf binaries
    glibc_multi
    stdenv.cc.cc
    zlib # zlib
    fuse3 # fuse
    fuse # fuse2
    libsecret

    # keyring
    gnome.seahorse
    gnome.gnome-keyring

    # cli tools
    coreutils-full # gnu utils
    gnumake
    file
    zip # archives
    unzip
    git
    git-filter-repo
    bfg-repo-cleaner
    gh # github cli
    curl
    wget
    rclone
    ripgrep
    fd # faster find
    fzf # fuzzy finder
    bat
    ranger # tui explorer
    jq # json parser
    stow
    socat
    openssl
    du-dust # du alternative
    envsubst

    # system
    htop # cpu/mem top
    nvtop # gpu top
    lsof # open files
    pciutils # lspci - pci devices
    acpi # battery
    neofetch

  ];

  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;

    # containers
    containerd.enable = true;
    docker.enable = true;
    #docker.rootless = {
    #enable = true;
    #setSocketVariable = true;
    #};
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
        libsecret # libsecret-1.so.0
        fuse3
        glib
        openssl
      ];
    };

    light =
      {
        enable = true;
      };

    #ssh = {
    #extraConfig = ''
    #IdentitiesOnly=yes
    #'';
    #};

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
    pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw 
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

    #variables = {
    #WLR_DRM_DEVICES="/dev/dri/card0:/dev/dri/card1";
    #};

  };

  # change the timeout duration
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=30s
  '';

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
