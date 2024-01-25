{ pkgs, config, ... }:
{

  # this is a mono-module for a opinionated i3 desktop implementation 

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

    # set i3 as window manager
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu # application launcher most people use
        i3status # gives you the default i3 status bar
        i3lock # default i3 screen locker
        i3blocks # if you are planning on using i3blocks over i3status
      ];

      # handle gnome keyring init
      extraSessionCommands = ''
        eval $(gnome-keyring-daemon --daemonize)
        export SSH_AUTH_SOCK
      '';
    };

  };

  # TODO: change this based on the updated config
  xdg = {
    portal = {
      enable = true;
      config = {
        common = {
          default = "*";
        };
      };
    };
  };


  # i3 packages
  environment.systemPackages = with pkgs; [

    polybarFull # status bar
    lxappearance # themes and icons
    rofi # app menu

    arandr # display mgmt
    libgestures # trackpad gestures on x11
    xdg-utils # opening default programs using links
    glib # gsettings

    # gnome keyring packages
    gnome.seahorse
    gnome.gnome-keyring

  ];

  # gnome keyring for x11
  services.gnome.gnome-keyring.enable = true;

  # polkit and pam
  security = {
    # policy kit for i3
    polkit.enable = true;

    # use i3 with gnome keyring
    pam.services.login.enableGnomeKeyring = true;
  };

  # enable gnome keyring for dbus
  services.dbus = {
    enable = true;
    packages = [
      pkgs.gnome.gnome-keyring
    ];
  };

  # light desktop manager
  programs = {
    light = {
      enable = true;
    };
  };
}
