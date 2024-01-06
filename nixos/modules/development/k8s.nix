{ pkgs, config, ... }: {

  environment.systemPackages = with pkgs; [

    kubectl
    argocd
    kubernetes-helm
    helmfile

    # dev tools
    tilt
    telepresence2
    devspace

    # cluster virt
    minikube
    kind

  ];

}
