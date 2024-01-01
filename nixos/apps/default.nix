{ pkgs, config, ... }: {

  imports = [
    ./thunar
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

    # notes/docs
    obsidian
    syncthing
    onlyoffice-bin
    libreoffice
    xournalpp

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
