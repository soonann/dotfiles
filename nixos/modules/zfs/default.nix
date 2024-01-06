{ pkgs, config, ... }: {

  # https://openzfs.github.io/openzfs-docs/Getting%20Started/NixOS/index.html
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.forceImportRoot = false;
  networking.hostId = "8fcd69c9";

  # import pool on boot
  boot.zfs.extraPools = [ "razerpool" ];

  # https://nixos.wiki/wiki/ZFS
  # kernel packages for zfs
  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;

  # autoscrubbing
  services.zfs.autoScrub.enable = true;

  # trim
  services.zfs.trim.enable = true;

}
