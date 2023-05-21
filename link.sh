# uses current working directory
CURR=$(pwd)

# -- create sym link for:
# bashrc
ln -s $CURR/.bashrc.d ~/

# nvim 
ln -s $CURR/nvim ~/.config/

# alacritty 
ln -s $CURR/alacritty ~/.config/

# tmux config 
ln -s $CURR/tmux/.tmux.conf ~/
ln -s $CURR/tmux/tmux-sessionizer ~/.local/bin/

# i3 config
ln -s $CURR/i3 ~/.config/


