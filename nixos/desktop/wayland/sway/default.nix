{ pkgs, config, ... }:
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
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP=sway
      systemctl --user stop pipewire wireplumber xdg-desktop-portal xdg-desktop-portal-wlr
      systemctl --user start pipewire wireplumber xdg-desktop-portal xdg-desktop-portal-wlr
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
    text =
      let
        schema = pkgs.gsettings-desktop-schemas;
        datadir = "${schema}/share/gsettings-schemas/${schema.name}";
      in
      ''
        export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
        gnome_schema=org.gnome.desktop.interface
        gsettings set $gnome_schema gtk-theme 'Dracula'
      '';
  };
in
{
  environment.systemPackages = with pkgs; [
    dbus-sway-environment # configure dbus for sway
    configure-gtk # configure dracula theme

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
    grim # image grabber
    slurp # screen selection 
    flameshot # screenshot -> broken :(
    swaybg # desktop bg

    # sway
    xdg-utils # opening default programs using links
    glib # gsettings
    waybar # status bar
    dracula-theme # dracula theme
    gnome.adwaita-icon-theme # default gnome icons

    # keyring
    gnome.seahorse
    gnome.gnome-keyring


  ];

  security.polkit.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;

  # gnome keyring
  gnome.gnome-keyring.enable = true;
  services.dbus = {
    enable = true;
    packages = [
      pkgs.gnome.gnome-keyring
    ];
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
    };
  };

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryFlavor = "gtk2"; # Hyprland/Wayland
    };

    light = {
      enable = true;
    };

    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };

  };

}
