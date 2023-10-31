# Installation Dependencies
1. Git
2. Stow

# Cloning
Note that this project uses submodules, to clone it with it submodules, use the following command:
```bash
# cd to your home directory
cd

# clone the dotfiles
git clone --recurse-submodules https://github.com/soonann/dotfiles.git 
```

# Installation
To install the dotfiles on your system, you can select the specific dir of dotfiles to install:
```bash
# installs only nvim tmux and alacritty
stow nvim tmux alacritty
```

Stow creates a symlink to your home directory at different locations depending on the structure of the dir selected

## Uninstall
To uninstall, simply run the following command:
```bash
stow -D nvim tmux alacritty 
```
