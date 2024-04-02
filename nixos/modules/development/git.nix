{ pkgs, config, ... }: {

  environment.systemPackages = with pkgs; [

    git
    git-lfs
    gh # github cli
    act # local github actions

    # filter/clean repo
    unstable.git-filter-repo
    bfg-repo-cleaner

  ];

}
