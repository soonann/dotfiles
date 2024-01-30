{pkgs, config, ...}:{

  # allow nfsv4
  networking.firewall.allowedTCPPorts = [ 2049 ];

  # enable nfs for zfs
  services.nfs.server.enable = true;

}
