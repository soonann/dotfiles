{ pkgs, config, ... }: {
  environment.systemPackages = with pkgs; [
    jdk17
    jdt-language-server
    gradle_7
  ];
}
