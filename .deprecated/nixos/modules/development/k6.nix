{ pkgs, config, ... }: {

  environment.systemPackages = with pkgs; [
    k6
  ];

}
