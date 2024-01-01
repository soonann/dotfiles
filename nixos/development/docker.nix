{ pkgs, config, ... }: {

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
