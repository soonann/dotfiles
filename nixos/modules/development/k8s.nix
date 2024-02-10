{ pkgs, config, ... }: {

  environment.systemPackages = with pkgs; [

    kubectl
    argocd
    unstable.kubernetes-helm
    helmfile

    # dev tools
    unstable.tilt
    telepresence2
    devspace

    # cluster virt
    minikube
    kind

  ];

}
