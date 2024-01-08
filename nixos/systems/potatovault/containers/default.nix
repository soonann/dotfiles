{pkgs, config, ...}:{
  imports = [
    ./vaultwarden
    #./nextcloud
  ];

  # networking for containers
  # https://nixos.org/manual/nixos/stable/#ch-containers
  networking = {

    nat = {
      enable = true;
      externalInterface = "enp2s0";
      internalInterfaces = ["ve-+"];
    };

    networkmanager.unmanaged = [ "interface-name:ve-*" ];

  };

  virtualisation = {
    # containers
    containerd.enable = true;
    docker.enable = true;

    # rootless docker
    #docker.rootless = {
      #enable = true;
      #setSocketVariable = true;
      #};
  };


  # add your user to docker group
  users.users.soonann.extraGroups = [ "docker" ];

  environment.systemPackages = with pkgs; [
    docker-compose
  ];



}
