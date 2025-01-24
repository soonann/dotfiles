#!/usr/bin/env bash

# check if the args exist
if [[ -z $1 || -z $2 ]]; then
  echo "usage in i3 config file"
  echo "bindsym \$ mod+o exec lazy-launcher '[instance="obsidian"]' 'scratchpad show'"
  echo "the following will launch obsidian and put it into the scratchpad"
fi;

# check if the window already exist
