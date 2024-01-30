{pkgs, config, ...}:{
  imports = [
    ./vaultwarden
    ./nextcloud
  ];

  # networking for containers
  # https://nixos.org/manual/nixos/stable/#ch-containers
  networking = {

    #nat = {
      #  enable = true;
      #  internalInterfaces = ["ve-+"];
      #  externalInterface = "enp2s0";
      #};

    bridges = {
      br0 = {
        interfaces = [ 
          "enp2s0"
        ];
      };
    };

    interfaces = {
      br0 = {
        ipv4.addresses = [
        { address = "10.0.0.10"; prefixLength = 24; }
        { address = "192.168.0.199"; prefixLength = 24; }
        ];
      };
    };

    defaultGateway = "192.168.0.1";
    nameservers = [ "192.168.0.1" ];

    

    #networkmanager.unmanaged = [ "interface-name:ve-*" ];

    };

    networking.firewall.interfaces."podman+".allowedUDPPorts = [ 53 ];

    virtualisation = {
      # containers
      containerd.enable = true;
      docker.enable = true;
      podman.enable = true;
      podman.defaultNetwork.settings = {
        dns_enabled = true;
      };

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
