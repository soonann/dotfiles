{ pkgs, config, ... }: {

  imports = [
    ./flatpak
    ./thunar
    ./steam
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
    obs-studio
    vlc
    gimp
    cura
    feh # image viewer
    scrcpy


    # notes/docs
    obsidian
    syncthing
    onlyoffice-bin # docs
    libreoffice # docs
    xournalpp # pdf editor
    evince # pdf viewer

    # email 
    thunderbird

    # networking
    tailscale

    # utilities
    gnome.gnome-calculator

  ];

  # enable tailscaled
  services.tailscale.enable = true;
}
