{ pkgs, config, ... }: {
  environment.systemPackages = with pkgs; [
    unstable.google-chrome
    chromedriver
  ];
}
