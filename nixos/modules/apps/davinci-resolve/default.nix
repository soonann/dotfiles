{ pkgs, config, ... }: {

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      intel-compute-runtime
    ];
  };

  environment.systemPackages = with pkgs; [
    davinci-resolve

  ];


}
