# polybar
#polybar-msg cmd quit
#echo "---" | tee -a /tmp/polybar.log
#polybar 2>&1 | tee -a /tmp/polybar.log & disown
printf '%.f' $(light) > /tmp/brightness

# bg
pkill -9 -f 'feh --bg-scale ~/dotfiles/wallpapers/fedora-black-4k.png'
feh --bg-scale ~/dotfiles/wallpapers/fedora-black-4k.png & disown

# picom &
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


razer touchpad
if [[ -n "$(xinput list-props 'CUST0001:00 06CB:CDA3 Touchpad' | grep 'Device Enabled (204):.*1')" ]]; then
    xinput set-prop 'CUST0001:00 06CB:CDA3 Touchpad' 'libinput Natural Scrolling Enabled' 1
    xinput set-prop 'CUST0001:00 06CB:CDA3 Touchpad' 'libinput Middle Emulation Enabled' 1
    xinput set-prop 'CUST0001:00 06CB:CDA3 Touchpad' 'libinput Disable While Typing Enabled' 1
    xinput set-prop 'CUST0001:00 06CB:CDA3 Touchpad' 'libinput Tapping Enabled' 1
fi

# glorious mouse
MOUSE=$(xinput list | grep 'Glorious Model O Wireless')
if [[ -n "$MOUSE" ]]; then
  xinput set-prop  'Glorious Model O Wireless' 'libinput Accel Profile Enabled' 0, 1
fi

# keyboard settings
xset r rate 220 40
setxkbmap -option caps:none # disable caps
