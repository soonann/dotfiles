# polybar
#polybar-msg cmd quit
#echo "---" | tee -a /tmp/polybar.log
#polybar 2>&1 | tee -a /tmp/polybar.log & disown
printf '%.f' $(light) > /tmp/brightness

# bg
pkill -9 -f 'feh --bg-scale ~/dotfiles/wallpapers/arch-black-4k.png'
feh --bg-scale ~/dotfiles/wallpapers/arch-black-4k.png & disown

picom &
pkill -9 -f 'picom'
picom & disown

# greenclip daemon
pkill -9 -f 'greenclip'
greenclip daemon & disown

# gnome keyring
rm -rf /run/user/1000/keyring
pkill -9 -f 'gnome-keyring-daemon --daemonize'
eval $(gnome-keyring-daemon --daemonize)
systemctl --user set-environment SSH_AUTH_SOCK=$SSH_AUTH_SOCK 

# monitor
. $HOME/.screenlayout/laptop-only.sh
. $HOME/.xprofile
