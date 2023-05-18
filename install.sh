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

# install tpm https://github.com/tmux-plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# install cargo before running this script
cargo install alacritty
cargo install ripgrep
