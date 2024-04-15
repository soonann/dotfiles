# install misc
pacman -S grub efibootmgr
networkmanager
neovim
git
tmux
i3-wm i3status
alacritty
xorg-xinit
lightdm
lightdm-gtk-greeter
alacritty
firefox
sudo
ssh
# install yay
pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si
   11  pacman -Syu
   12  sudo pacman -Syu
   15  pacman 
   16  pacman -h
   17  pacman -R pulseaudi
   18  sudo pacman -R pulseaudio
   19  sudo pacman -R pipewire-pulse
   20  sudo pacman -S pipewire-pulse
   26  sudo pacman -S pamixer
   31  pacman -Syu
   32  sudo pacman -Syu
   33  sudo pacman -Q
   34  sudo pacman -Q | grep pipe
   41  pacman -S sof-firmware
   42  sudo pacman -S sof-firmware
   55  pacman -S nvidia-lts
   56  sudo pacman -S nvidia-lts
  101  sudo pacman -S xinput
  102  sudo pacman -S xorg-xinput
  103  sudo pacman -S xorg-xset
  113  sudo pacman -S lxappearance
  115  pacman -S adawait
  116  sudo pacman -S adawait
  117  sudo pacman -Sadwaita-icon-theme
  118  sudo pacman -S adwaita-icon-theme
  144  pacman -S libgestures
  145  sudo pacman -S libgestures
  156  sudo pacman -S glib
  157  sudo pacman -S dconf-editor
  161  sudo pacman -S bash-completion
  188  sudo pacman -S thunar
  212  sudo pacman -S tree
  235  sudo pacman -S thunar-archive-plugin thunar-volman
  236  sudo pacman -S thunar-media-tags-plugi
  237  sudo pacman -S thunar-media-tags-plugin
  245  sudo pacman -S bluez bluez-utils
  256  sudo pacman -S blueman
  288  pacman -S aws-cli 
  289  sudo pacman -S aws-cli 
  290  sudo pacman -S virtualenv
  291  sudo pacman -S python-virtualenv
  309  pacman -S gnome-themes-extra
  310  sudo pacman -S gnome-themes-extra
  494  sudo pacman -S lsof
  504  sudo pacman -S noto-fonts
  505  sudo pacman -S noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra
  509  history | grep pacman
  510  history | grep pacman >> dotfiles/arch/installs.sh 
  146  yay libinput-gestures
  244  yay android-studio
  308  yay adwaita-dark
  485  yay android-studio
  511  history | grep yay >> dotfiles/arch/installs.sh 
