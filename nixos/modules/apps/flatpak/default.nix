{ pkgs, config, ... }: {

  environment.systemPackages = with pkgs; [

    # flatpak
    flatpak
    gnome.gnome-software
  ];

  services.flatpak.enable = true;

}
