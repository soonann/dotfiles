{ pkgs, config, ... }:
{
  # nfs boot params
  boot = {
    supportedFilesystems = [ "nfs" ];
    kernelModules = [ "nfs" ];
  };

  # needed for NFS
  services.rpcbind.enable = true;

  # nfs utils packages
  environment.systemPackages = with pkgs; [
    nfs-utils
  ];
}
