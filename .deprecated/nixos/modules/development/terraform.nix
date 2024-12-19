{ pkgs, config, ... }: {

  environment.systemPackages = with pkgs; [
    terraform
    terraform-lsp

  ];

}
