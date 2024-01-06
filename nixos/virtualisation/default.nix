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

  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [
    virtiofsd # vm file sharing 
  ];

}
