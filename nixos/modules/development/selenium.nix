{ pkgs, config, ... }: {
  environment.systemPackages = with pkgs; [
    google-chrome
    chromedriver
  ];
}
