# add the following to your .bashrc
# # User specific aliases and functions
# if [ -d ~/.bashrc.d ]; then
#         for rc in ~/.bashrc.d/*; do
#                 if [ -f "$rc" ]; then
#                         . "$rc"
#                 fi
#         done
# fi
# 
# unset rc

# install nvim https://github.com/neovim/neovim

# install packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# install tpm https://github.com/tmux-plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# install the following 
# gcc g++ cmake 

# install cargo before running this script - tree-sitter and ripgrep
cargo install tree-sitter-cli
cargo install ripgrep

# install fzf https://github.com/junegunn/fzf

# install fd https://github.com/sharkdp/fd

# i3 installation
# https://www.reddit.com/r/Fedora/comments/l1fd13/how_difficult_is_it_to_set_up_i3wm_on_fedora/
  sudo dnf install 
      i3 \ # i3
      i3status \ # status bar for i3
      i3lock \ # sleep and lock with - supports xss-lock
      xbacklight \ # adjust backlight with xrandr
      xinput # set trackpad settings
      dmenu \ # app launcher
      feh \ 
      conky \ 

