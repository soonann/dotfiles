# support both 32- and 64-bit applications

{ pkgs, config, ... }: {
  environment.systemPackages = with pkgs; [
    wineWowPackages.stable
  ];
}
