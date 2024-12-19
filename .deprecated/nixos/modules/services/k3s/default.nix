{pkgs, config, ...}:{
  # https://nixos.wiki/wiki/K3s
  networking.firewall.allowedTCPPorts = [
    6443 # k3s: required so that pods can reach the API server (running on port 6443 by default)
    # 2379 # k3s, etcd clients: required if using a "High Availability Embedded etcd" configuration
    # 2380 # k3s, etcd peers: required if using a "High Availability Embedded etcd" configuration
  ];
  networking.firewall.allowedUDPPorts = [
    # 8472 # k3s, flannel: required if using multi-node for inter-node networking
  ];

  # setup k3s service
  services = {
    k3s.enable = true;
    k3s.role = "server";
    k3s.extraFlags = toString [
      # "--kubelet-arg=v=4" # Optionally add additional args to k3s
    ];
  };
  
  # packages for k3s
  environment.systemPackages = with pkgs; [ 
    k3s 
    kubectl
    kubernetes-helm
    helmfile
  ];
                    }
