{ pkgs, config, ... }: {

  imports = [
    ./flatpak
    ./steam
    ./thunar
    ./obs-studio
    ./virtual-box
    ./wine
    ./onlyoffice
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
    obsidian
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
