{ pkgs, config, ... }: {

  # packages
  environment.systemPackages = with pkgs; [
    virtiofsd # vm file sharing 
  ];

  # enable virtualisation
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        # setup ovmf and swtpm for windows vms
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [
          pkgs.OVMFFull.fd
        ];
      };
    };
    spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;

  users.users.soonann = {
    extraGroups = [
      "libvirt"
      "libvirtd"
      "kvm"
    ];
  };

  programs.virt-manager.enable = true;

}
