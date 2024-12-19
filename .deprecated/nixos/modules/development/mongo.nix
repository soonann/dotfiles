{ pkgs, config, ... }: {
  environment.systemPackages = with pkgs; [
    mongosh
    mongodb-compass
  ];
}
