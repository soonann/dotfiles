{ pkgs, config, ... }: {
  environment.systemPackages = with pkgs; [
    nasm
  ];
}
