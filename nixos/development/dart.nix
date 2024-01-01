{ pkgs, config, ... }: {
  environment.systemPackages = with pkgs; [
    flutter
  ];
}
