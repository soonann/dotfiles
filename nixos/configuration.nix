# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, modulesPath, pkgs, ... }:
let
in
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # modules
      ./apps
      ./development
      ./virtualisation
      ./desktop/x11/i3
      #./desktop/wayland/sway
      ./nvidia/razer-blade-stealth-13-2021
      ./fonts

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



  # Enable sound with pipewire.
  sound.enable = true;
  hardware = {
    bluetooth.enable = true;
    bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
    pulseaudio.enable = false;
  };
  security.rtkit.enable = true; # gnome-defaults

  # enable picom
  services.picom.enable = true;

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


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.soonann = {
    isNormalUser = true;
    description = "Soon Ann";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "dialout" # writing to /dev/ttyACM0
    ];
  };

  nixpkgs = {
    # Allow unfree packages
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "electron-24.8.6"
        "electron-25.9.0"
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

    pavucontrol # pulse-audio gui
    pamixer # pulse-audio cli
    flameshot # screenshot -> broken :(
    rofi # app menu

    zfs # for zfs support
    btrfs-progs # for btrfs support

    # cope
    vscode

    # ops
    vault
    certbot

    # gpg
    gnupg
    pinentry # for the gpg to prompt

    # libs
    #set-libs
    nix-index # nix-locate
    appimage-run # run app images
    patchelf # patch elf binaries
    glibc_multi
    stdenv.cc.cc
    zlib # zlib
    fuse3 # fuse
    fuse # fuse2
    libsecret

  ];

  programs = {
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        zlib # zlib.so
        fuse # fuse.so.2
        libsecret # libsecret-1.so.0
        stdenv.cc.cc # gcc
        gcc_multi
        fuse3
        glib
        openssl
      ];
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
  system.stateVersion = "23.11"; # Did you read the comment?

}
