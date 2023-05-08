# uses current working directory
CURR=$(pwd)

# -- create sym link for
# nvim dotfiles
ln -s $CURR/nvim ~/.config/

# alacritty dotfiles
ln -s $CURR/alacritty ~/.config/

# tmux config dotfiles
ln -s $CURR/tmux/.tmux.conf ~/
ln -s $CURR/tmux/tmux-sessionizer ~/.local/bin/
