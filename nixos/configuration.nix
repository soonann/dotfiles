# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./hosts.nix
    ];

  # boot
  boot = {
    # zfs support
    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
    kernelParams = [
      "nohibernate"
    ];
    supportedFilesystems = [
      "zfs"
    ];

    # others
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  # Networking
  networking = {
    hostId = "9449bc67";
    hostName = "nixos"; # Define your hostname.
    networkmanager.enable = true; # Enable networking

    #firewall.allowedTCPPorts = [
    #443
    #80
    #];
    # Open ports in the firewall.
    #firewall.allowedTCPPorts = [ 6443 ];
    #firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.

    #wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    #proxy.default = "http://user:password@proxy:port/";
    #proxy.noProxy = "127.0.0.1,localhost,internal.domain"; 
    #firewall.enable = false;
  };

  # Hardware
  hardware = {
    bluetooth.enable = true;

    # https://nixos.wiki/wiki/Nvidia#Laptop_Configuration:_Hybrid_Graphics_.28Nvidia_Optimus_PRIME.29
    # nvidia 
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    # actual nvidia drivers
    #nvidia = {
    ### Modesetting is required.
    #modesetting.enable = true;

    ### Enable power management (do not disable this unless you have a reason to).
    ### Likely to cause problems on laptops and with screen tearing if disabled.
    #powerManagement.enable = true;

    ### Use the NVidia open source kernel module (not to be confused with the
    ### independent third-party "nouveau" open source driver).
    ### Support is limited to the Turing and later architectures. Full list of 
    ### supported GPUs is at: 
    ### https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    ### Only available from driver 515.43.04+
    ### Do not disable this unless your GPU is unsupported or if you have a good reason to.
    #open = true;

    ### Enable the Nvidia settings menu,
    ### accessible via `nvidia-settings`.
    #nvidiaSettings = true;

    ### Optionally, you may need to select the appropriate driver version for your specific GPU.
    #package = config.boot.kernelPackages.nvidiaPackages.stable;
    #};
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
    packages = with pkgs; [ ];
  };

  # Nixpkgs/Nix
  nixpkgs = {
    config.allowUnfree = true;
    #overlays = [
    #(final: prev:
    #{
    #polybarFull = prev.polybarFull.overrideAttrs (old: {
    #src = prev.fetchFromGitHub {
    #owner = "polybar";
    #repo = "polybar";
    #rev = "2471f3595c3ca582fe0b0abcd3ce9a03ff144f23";
    #hash = "sha256-fRjqY7RxhbwTHKtmohmkC5n9MVoRb0yInF2HPw7Jppw=";
    #};
    #});
    #})
    #];
    #overlays = [
    ## android studio xdg-current-desktop overlay
    #(final: prev: {
    #android-studio = prev.android-studio.overrideAttrs (oldAttrs: {
    #postInstall = (oldAttrs.postInstall or "") + ''
    #substituteInPlace $out/share/applications/android-studio.desktop \
    #--replace "Exec=android-studio" "Exec=env QT_QPA_PLATFORM=xcb android-studio"
    #'';
    #});
    #})
    #];
  };

  nix = {
    settings.experimental-features = "nix-command flakes";
    #gc = {
    #automatic = true;
    #dates = "weekly";
    #options = "--delete-older-than 7d";
    #};
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

    blueman # bluetooth manager gui
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
    telegram-desktop
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

    # development
    vim
    neovim
    alacritty
    tmux
    scrcpy
    unstable.android-studio
    gradle_7
    unstable.bruno
    k6
    mongosh

    # kubernetes
    minikube
    kind
    kubectl
    kubernetes-helm
    telepresence2
    tilt
    devspace
    helmfile
    dagger

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
    gcc

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
    curl
    wget
    rclone
    ripgrep
    fd
    fzf
    bat
    ranger
    jq
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

  security.polkit.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;

  virtualisation = {

    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;

    containerd.enable = true;

    docker.enable = true;
    #docker.rootless = {
    #enable = true;
    #setSocketVariable = true;
    #};

  };

  # List services that you want to enable:
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  services = {

    greenclip.enable = true;

    # fix screen tearing on i3
    picom = {
      enable = true;
      vSync = true;
    };

    # Configure keymap in X11
    xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "";

      # video drivers
      #videoDrivers = [
      #"modesetting" # default
      #"nouveau" # no power management
      #"nvidia"
      #];

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

    };

    gnome.gnome-keyring.enable = true;

    dbus = {
      enable = true;
      packages = [
        pkgs.gnome.gnome-keyring
      ];
    };

    pipewire = {
      enable = true;
      wireplumber.enable = true;
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
    };
  };

  #qt = {
  #enable = true;
  #platformTheme = "";
  #style = "";
  #};

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
        glibc_multi
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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
