{ pkgs, config, ... }: {

  # enable virtualisation
  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };

  programs.virt-manager.enable = true;

  users.users.soonann = {
    extraGroups = [
      "libvirt"
      "libvirtd"
      "kvm"
    ];
  };

  environment.systemPackages = with pkgs; [
    virtiofsd # vm file sharing 
  ];

}
