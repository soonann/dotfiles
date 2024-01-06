{ pkgs, config, ... }: {
  environment.systemPackages = with pkgs; [
    awscli2
    (google-cloud-sdk.withExtraComponents [ google-cloud-sdk.components.gke-gcloud-auth-plugin ])
  ];
}
