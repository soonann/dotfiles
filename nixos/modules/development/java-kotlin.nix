{ pkgs, config, ... }:
let
  # androidStudioOverlay = final: prev: {
  #   androidStudio = prev.androidStudio.overrideAttrs (oldAttrs:
  #     let
  #       version = "2023.3.1.16";
  #       channel = "canary";
  #     in
  #     {
  #       # https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2023.3.1.16/android-studio-2023.3.1.16-linux.tar.gz
  #       drvName = "android-studio-${channel}-${version}";
  #       filename = "android-studio-${version}-linux.tar.gz";
  #       src = prev.fetchurl {
  #         url = "https://dl.google.com/dl/android/studio/ide-zips/2023.3.1.16/android-studio-2023.3.1.16-linux.tar.gz
  # ";
  #         sha256 = "sha256-uvnvli/c49fLv+YUNGyrBgq5749g9RuBw882WgWAuuI=";
  #       };
  #     }
  #   );
  # };
in
{
  programs.adb.enable = true;
  users.users.soonann.extraGroups = [ "adbusers" ];
  environment.systemPackages = with pkgs; [
    jdk17
    jdt-language-server
    gradle_7

    # android
    android-studio
  ];

  # nixpkgs.overlays = [
  #   androidStudioOverlay
  # ];

  services.udev.packages = [
    pkgs.android-udev-rules
  ];

}
