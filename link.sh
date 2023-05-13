# uses current working directory
CURR=$(pwd)

# -- create sym link for:
# bash aliases
ln -s $CURR/bash/.bash_aliases ~/.bash_aliases

# nvim dotfiles
ln -s $CURR/nvim ~/.config/

# alacritty dotfiles
ln -s $CURR/alacritty ~/.config/

# tmux config dotfiles
ln -s $CURR/tmux/.tmux.conf ~/
ln -s $CURR/tmux/tmux-sessionizer ~/.local/bin/
