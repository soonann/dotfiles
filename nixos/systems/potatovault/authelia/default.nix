{config, pkgs, ...}: {
  services.authelia.instances = {
    main = {
      enable = true;
      secrets.storageEncryptionKeyFile = "/run/appdata/authelia/storageEncryptionKeyFile";
      secrets.jwtSecretFile = "/run/appdata/authelia/jwtSecretFile";
      settings = {
        theme = "dark";
        default_2fa_method = "totp";
        log.level = "debug";
        server.disable_healthcheck = true;
        server.host = "0.0.0.0";
      };
    };
  };
}
