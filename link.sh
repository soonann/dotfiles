# uses current working directory
CURR=$(pwd)

# -- create sym link for
# nvim dotfiles
ln -s $CURR/nvim ~/.config/nvim

# alacritty dotfiles
ln -s $CURR/alacritty ~/.config/alacritty

# tmux config dotfiles
ln -s $CURR/tmux/.tmux.conf ~/.tmux.conf
