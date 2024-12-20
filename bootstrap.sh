#!/usr/bin/env bash

# Install git and ansible
sudo dnf install -y git ansible stow

# Clone dotfiles
# git clone git@github.com:soonann/dotfiles.git

# Install ansible community collections and roles
# ansible-galaxy install -r requirements.yml

echo 'You can now apply the playbook with:'
echo 'ansible-playbook -K -c local -i localhost, main.yml'
