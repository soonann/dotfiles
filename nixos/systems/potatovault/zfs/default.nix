{pkgs, config, ...}: {

  # https://openzfs.github.io/openzfs-docs/Getting%20Started/NixOS/index.html
  boot.supportedFilesystems = [ "zfs" ];
  networking.hostId = "f839bdb9";
  boot.zfs.forceImportRoot = false;

  # import pool on boot
  boot.zfs.extraPools = [ "potatopool" ];

  # https://nixos.wiki/wiki/ZFS
  # kernel packages for zfs
  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;

  # autoscrubbing
  services.zfs.autoScrub.enable = true;

  # trim
  services.zfs.trim.enable = true;

}

