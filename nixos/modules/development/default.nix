{ pkgs, config, ... }: {
  imports = [
    # language environments
    ./assembly.nix
    ./c.nix
    ./rust.nix
    ./golang.nix
    ./dart.nix
    ./java-kotlin.nix
    ./python.nix
    ./js.nix

    # containers
    ./k8s.nix
    ./docker.nix

    # infra/ops
    ./git.nix
    ./ansible.nix
    ./cloud-cli.nix
    ./terraform.nix

    # database
    ./mongo.nix

    # testing
    ./k6.nix
    ./selenium.nix

  ];

  documentation.man = {
    # In order to enable to mandoc man-db has to be disabled.
    man-db.enable = true;
  };
  documentation.dev.enable = true;

  # essential cli tools
  environment.systemPackages = with pkgs; [

    # development
    vim
    neovim
    alacritty
    tmux
    tmate # tmux sharing
    ranger # tui explorer
    ffmpeg # process media

    # man pages
    linux-manual
    man-pages
    man-pages-posix

    # cli tools
    coreutils-full # gnu utils
    busybox
    pv
    openssl
    age
    rclone
    curl
    wget
    zip
    unzip
    file
    envsubst
    jq
    gnumake

    # improved
    du-dust # du alternative
    fd # faster find
    fzf # fuzzy finder
    ripgrep
    bat

    # system monitoring
    neofetch
    htop # cpu/mem top
    lsof # open files
    lshw # find gpu id
    pciutils # lspci - pci devices
    acpi # battery
    socat # socket cat

    # manage dotfiles
    stow

    # ngrok
    zrok

    # ollama
    ollama

  ];
}
