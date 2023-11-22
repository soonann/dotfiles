# this script assumes you're running from a freshly install system
# you should have already made sure the following are working:
# 1. sudo access - add your current user to the sudo/wheel group and ensure they're able to run privileged commands
# 2. git over ssh - download a browser of your choice and add a new public key to your git account
# 3. cloned dotfiles with git - clone the project to your home directory
# 4. rc.d - added the following script to your .bashrc or .zshrc
#if [ -d ~/.rc.d ]; then
# for rc in ~/.rc.d/*; do
#	 if [ -f "$rc" ]; then
#		 . "$rc"
#	 fi
# done
#fi
#unset rc

sudo apt install ansible
