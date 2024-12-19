{ pkgs, config, ... }: {
  environment.systemPackages = with pkgs; [
    gcc_multi
    gdb
  ];
}
