#!/bin/bash

echo "Installing Ubuntu Server Sync..."
sudo apt-get update > /dev/null
sudo apt-get install -y git > /dev/null
mkdir -p $HOME/.local/{bin,share}
rm -rf $HOME/.local/{bin,share}/ubuntu-server-sync
git clone https://github.com/goransimic/ubuntu-server-sync.git $HOME/.local/share/ubuntu-server-sync
ln -sv $HOME/.local/share/ubuntu-server-sync/sync.sh $HOME/.local/bin/ubuntu-server-sync
