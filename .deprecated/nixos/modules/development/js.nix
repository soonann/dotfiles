{ pkgs, config, ... }: {
  environment.systemPackages = with pkgs; [
    nodejs
    yarn
  ];
}
