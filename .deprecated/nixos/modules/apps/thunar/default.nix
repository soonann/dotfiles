{ pkgs, config, ... }: {

  environment.systemPackages = with pkgs; [
    # file exporer
    xfce.thunar-volman
    xfce.thunar-archive-plugin
    gnome.file-roller

  ];

  services = {
    gvfs.enable = true; # thunar - Mount, trash, and other functionalities
    tumbler.enable = true; # thunar - Thumbnail support for images
  };

  programs = {

    # enable thunar
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };

    # since xfce is not used, we need to enable this to persist configs
    xfconf.enable = true;
  };
}
