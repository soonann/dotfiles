{ pkgs, config, ... }: {
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
  virtualisation.virtualbox.guest.x11 = true;
  users.extraGroups.vboxusers.members = [ "soonann" ];
}
