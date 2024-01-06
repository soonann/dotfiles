#!/usr/bin/env bash

echo 'this script is meant as a reference only'
echo 'exiting ...'
exit 1

# setup zpool
# use compatibility mode to allow exporting to other systems
zpool create 
  -o ashift=12 \ 
  -o compatibility=/nix/store/ipyfxzcmsv4x3kn8i4pvqjsw183avy85-zfs-user-2.1.12/share/zfs/compatibility.d/grub2 \
  potatopool \ 
  raidz1 \ 
  /dev/sdx /dev/sdy /dev/sdz

# create required datasets
zfs create -o xxx -o xxx potatopool/<dataset>
zfs set compression=lz4 rpool/local/nix

# create nfs share
# https://nixos.wiki/wiki/ZFS
# for more info, look at man exports(5)
zfs set sharenfs="ro=192.168.1.0/24,all_squash,anonuid=70,anongid=70" potatopool/appdata
