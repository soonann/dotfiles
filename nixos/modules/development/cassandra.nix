{ pkgs, config, ... }: {

  environment.systemPackages = with pkgs; [
    cassandra
  ];

}
