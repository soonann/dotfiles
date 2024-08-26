#!/usr/bin/env bash

echo 'this script is meant as a reference only'
echo 'exiting ...'
exit 1

# you might want to add compatibility to make it compatible with other systems
# -o compatibility=/nix/store/ipyfxzcmsv4x3kn8i4pvqjsw183avy85-zfs-user-2.1.12/share/zfs/compatibility.d/grub2 \

# setup zpool
zpool create 
  -o ashift=12 \ 
  potatopool \ 
  raidz1 \ 
  /dev/sdx /dev/sdy /dev/sdz

# setup cachepool
zpool create 
  -o ashift=12 \ 
  cachepool \ 
  mirror \ 
  /dev/sda /dev/sdb


# should be enabled by default, but can enable just in case
zpool set feature@allocation_classes=enable potatopool

# create mirror for special device
zpool add  \ 
  potatopool \ 
  special \ 
  mirror /dev/sde1 /dev/sdf1

# create required datasets
zfs create -o xxx -o xxx potatopool/<dataset>

# set compression if required
zfs set compression=lz4 potatopool/<dataset>

# create nfs share
# https://nixos.wiki/wiki/ZFS
# for more info, look at man exports(5)
zfs set sharenfs="ro=192.168.1.0/24,all_squash,anonuid=70,anongid=70" potatopool/appdata

# upgraded zpool
#Enabled the following features on 'potatopool':
#  multi_vdev_crash_dump
#  large_dnode
#  sha512
#  skein
#  edonr
#  userobj_accounting
#  encryption
#  project_quota
#  device_removal
#  obsolete_counts
#  zpool_checkpoint
#  spacemap_v2
#  resilver_defer
#  bookmark_v2
#  redaction_bookmarks
#  redacted_datasets
#  bookmark_written
#  log_spacemap
#  livelist
#  device_rebuild
#  zstd_compress
#  draid
#  zilsaxattr
#  head_errlog
#  blake3
#  block_cloning
#  vdev_zaps_v2
