{ pkgs, config, ... }: {

  # enable virtualisation
  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };

  users.users.soonann = {
    extraGroups = [
      "libvirt"
      "libvirtd"
      "kvm"
    ];
  };

  environment.systemPackages = with pkgs; [
    virt-manager # vm gui
    virtiofsd # vm file sharing 

  ];

}
