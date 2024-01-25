{ pkgs, config, ... }: {
  programs.adb.enable = true;
  users.users.soonann.extraGroups = [ "adbusers" ];
  environment.systemPackages = with pkgs; [
    jdk17
    jdt-language-server
    gradle_7

    # android
    android-studio

  ];

  services.udev.packages = [
    pkgs.android-udev-rules
  ];

}
