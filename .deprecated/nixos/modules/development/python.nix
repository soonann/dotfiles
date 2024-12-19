{ pkgs, config, ... }:
let
  custom-python-pkgs = ps: with ps; [
    python-lsp-server
    flake8
    pip
  ];
  custom-python311 = pkgs.python3.withPackages custom-python-pkgs;

in
{
  environment.systemPackages = with pkgs; [
    custom-python311
  ];
}
