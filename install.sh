#!/usr/bin/env bash

# Move into executing directory
cd "$(dirname "$BASH_SOURCE")"

# git updated
git pull origin master
git submodule init
git submodule update

# Sync files
function syncUp() {
  # Sync files to ~
  rsync --exclude "sublime/" --exclude "terminal/" --exclude "adobe-ps-ico-plugin/" --exclude ".git/" --exclude ".DS_Store" --exclude "install.sh" --exclude "README.md" -av . ~
  
  # Sync sublime settings
  sublPath=~/Library/Application\ Support/Sublime\ Text\ 2/
  if [ -d "$sublPath" ]
  then
    rsync -av ./sublime/ "$sublPath"
  fi
}

# Warn of overwrites
read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  syncUp
fi
unset syncUp

# Bring in the bash
source ~/.bash_profile
