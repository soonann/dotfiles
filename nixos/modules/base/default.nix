{ pkgs, config, ... }:{
  environment.systemPackages = with pkgs; [
    age
  ];
}
