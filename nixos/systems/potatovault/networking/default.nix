{pkgs, config, ...}:{

  # basic networking settings
  networking = {
    hostName = "potatovault"; # Define your hostname
    #useDHCP = false;
    #interfaces = {
    #  enp2s0.ipv4.addresses = [
    #    {
    #      address = "192.168.0.199";
    #      prefixLength = 24;
    #    }
    #  ];
    #};
    #defaultGateway = "192.168.0.1";
    #nameservers = [ "192.168.0.1" ];
  };


  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  #networking = {
  #  firewall = {
  #    enable = true;
  #    allowedTCPPorts = [ 5900 ];
  #  };
  #};
}
