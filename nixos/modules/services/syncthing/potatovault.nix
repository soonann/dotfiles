{config, pkgs, ... }: {
  services = {
    syncthing = {
      enable = true;
      user = "soonann";
      dataDir = "/run/appdata/syncthing/data";
      configDir = "/run/appdata/syncthing/config";
      guiAddress = "100.69.13.103:8384";
      #overrideDevices = true;     # overrides any devices added or deleted through the WebUI
      #overrideFolders = true;     # overrides any folders added or deleted through the WebUI
      settings = {
        devices = {
          "bladestealth" = { id = "QQWDD32-YUYZGK2-FC44ZUM-TQBA2QW-LX5DRWG-LJR4GHO-QAU5JFM-ORLABA5"; };
          "s21fe" = { id = "P3VOGHU-62SCPL2-CSY5JE3-Z3RGOCF-A3Y3TW5-P3Y2RY6-MHE77XJ-YGAU2Q4"; };
        };
        folders = {
          "obsidian" = {
            path = "/run/appdata/syncthing/data/obsidian";
            devices = [ "bladestealth" "s21fe" ];
          };
        };
      };
    };
  };

  # 22000 TCP and/or UDP for sync traffic
  # 21027/UDP for discovery
  # source: https://docs.syncthing.net/users/firewall.html
  networking.firewall.allowedTCPPorts = [ 8384 22000 ];
  networking.firewall.allowedUDPPorts = [ 22000 21027 ];

}
