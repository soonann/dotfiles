{ pkgs, config, ... }:
let
  # get the latest brave version
  braveOverlay = final: prev: {
    brave = prev.brave.overrideAttrs (oldAttrs:
      let
        version = "1.63.157";
      in
      {
        src = prev.fetchurl {
          url = "https://github.com/brave/brave-browser/releases/download/v${version}/brave-browser_${version}_amd64.deb";
          hash = "sha256-M8QdA4eA6tOoY106sLohOrjTCnaRBSH/F546hLi8TFg=";
        };
      }
    );
  };
in
{

  imports = [
    ./flatpak
    ./steam
    ./thunar
    ./obs-studio
    ./virtual-box
    ./wine
    ./onlyoffice
  ];

  nixpkgs.overlays = [
    braveOverlay
  ];

  environment.systemPackages = with pkgs; [

    # browser
    brave
    firefox

    # chat
    telegram-desktop
    discord
    zoom-us
    slack
    pidgin # irc

    # media
    spotify
    vlc
    gimp
    cura
    feh # image viewer
    scrcpy


    # notes/docs
    unstable.obsidian
    #onlyoffice-bin # docs
    libreoffice # docs
    xournalpp # pdf editor
    evince # pdf viewer

    # email 
    thunderbird

    # utilities
    gnome.gnome-calculator

  ];

  # syncthing
  services = {
    syncthing = {
      enable = true;
      user = "soonann";
      dataDir = "/home/soonann/development/syncthing/data";
      configDir = "/home/soonann/development/syncthing/config";
    };
  };

  programs.onlyoffice.enable = true;
}
