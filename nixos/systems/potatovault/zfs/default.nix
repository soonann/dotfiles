{pkgs, config, ...}: {

  # https://openzfs.github.io/openzfs-docs/Getting%20Started/NixOS/index.html
  boot.supportedFilesystems = [ "zfs" ];
  networking.hostId = "f839bdb9";
  boot.zfs.forceImportRoot = false;

  # import pool on boot
  boot.zfs.extraPools = [ "potatopool" "cachepool" ];

  # https://nixos.wiki/wiki/ZFS
  # kernel packages for zfs
  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;

  # autoscrubbing - data integrity
  services.zfs.autoScrub.enable = true;

  # trim - reclaim space 
  services.zfs.trim.enable = true;

  # sanoid
  services.sanoid = {
		enable = true;
		package = pkgs.sanoid;
		templates = {
			"prod" = {
				monthly = 2;
				daily = 30;
				hourly = 24;
				autoprune = true;
				autosnap = true;
			};
		}; 
		datasets = {
			"potatopool/data" = {
				use_template = [ "prod" ];
				recursive = true;
			};
			"potatopool/local" = {
				use_template = [ "prod" ];
				recursive = true;
			};
			"potatopool/unraid" = {
				use_template = [ "prod" ];
				recursive = true;
			};
			"cachepool/secrets" = {
				use_template = [ "prod" ];
				recursive = true;
			};
			"cachepool/appdata" = {
				use_template = [ "prod" ];
				recursive = true;
			};
		};
  }; 

}

