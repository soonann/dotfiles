# polybar
polybar-msg cmd quit
echo "---" | tee -a /tmp/polybar.log
polybar 2>&1 | tee -a /tmp/polybar.log & disown

# bg
feh --bg-scale ~/dotfiles/wallpapers/nix-black-4k.png

# gnome keyring
rm -rf /run/user/1000/keyring
pkill -9 -f 'gnome-keyring-daemon --daemonize'
eval $(gnome-keyring-daemon --daemonize)
systemctl --user set-environment SSH_AUTH_SOCK=$SSH_AUTH_SOCK 
