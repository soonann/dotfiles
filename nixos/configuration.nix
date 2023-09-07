# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let

  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-environment";
    executable = true;

    text = ''
      dbus-update-activation-environment --system WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
      systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
      systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
    '';
  };

  configure-gtk = pkgs.writeTextFile {
    name = "configure-gtk";
    destination = "/bin/configure-gtk";
    executable = true;
    text = let
      schema = pkgs.gsettings-desktop-schemas;
      datadir = "${schema}/share/gsettings-schemas/${schema.name}";
    in ''
      export XDG_DATA_DIR=${datadir}:$XDG_DATA_DIRS
      gnome_schema=org.gnome.desktop.interface
      gsettings set $gnome_schema gtk-theme 'Dracula'
    '';
  };

in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./hosts.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  hardware.bluetooth.enable = true;

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

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.soonann = {
    isNormalUser = true;
    description = "Soon Ann";
    extraGroups = [ "libvirtd" "networkmanager" "wheel" "video" "docker" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = "nix-command flakes";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

    # sway
    dbus-sway-environment
    configure-gtk
    wayland
    xdg-utils
    glib
    dracula-theme
    gnome3.adwaita-icon-theme
    swayidle
    swaylock
    grim
    slurp
    wl-clipboard
    bemenu
    rofi
    mako
    wdisplays
    pulseaudio
    pavucontrol
    light
    waybar
    blueman
    flameshot
    kanshi
    gparted

    # utility
    brave
    thunderbird
    #evolution
    evolution-ews
    #protonmail-bridge
    spotify
    discord    
    obsidian
    slack
    telegram-desktop
    #xfce.thunar
    xfce.thunar-volman
    xfce.thunar-archive-plugin
    xarchiver
    gvfs
    tailscale
    libreoffice
    libsecret
    gnome.gnome-keyring
    gnome.seahorse
    obs-studio
    zoom-us
    vlc
    ffmpeg
    stdenv.cc.cc.lib

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
    curl
    wget
    fd
    fzf
    unzip
    rclone
    kubectl
    lsof
    file
    dos2unix
    appimage-run
    gnumake
    btrfs-progs

    gnupg
    pinentry

    htop
    nvtop
    docker-compose
    #k3s
    #ipset

    # languages
    go
    python311
    python311Packages.pydevtool
    python311Packages.pyaudio
    virtualenv
    jdk17
    rustup
    cargo

    gcc_multi
    glibc
    gdb
    nodejs
    flutter
    virt-manager 
    woeusb


  ];
  

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  #programs.gnupg.agent = {
    #enable = true;
    #enableSSHSupport = true;
  #};

  #programs.hyprland = {
    #enable = true;
    #nvidiaPatches = true;
    #xwayland.enable = true;
  #};

  programs.nix-ld.enable = true;

  programs.seahorse.enable = true;

  #programs.evolution = {
    #enable = true;
    #plugins = [ pkgs.evolution-ews ];
  #};
  
  security.polkit.enable = true;

  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  # List services that you want to enable:
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  services.dbus.enable = true;
  services.dbus.packages = with pkgs; [
    xfce.xfconf
  ];
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };


  services.blueman.enable = true;

  services.gvfs.enable = true; # Mount, trash, and other functionalities
    services.tumbler.enable = true; # Thumbnail support for images

  services.tailscale.enable = true;
  services.flatpak.enable = true;
  services.gnome.gnome-keyring.enable = true;

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
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Fonts
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "Hack" ]; })
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
