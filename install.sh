#!/bin/bash

echo "Installing Ubuntu Server Sync..."
sudo apt-get update > /dev/null
sudo apt-get install -y git > /dev/null
mkdir -p $HOME/.local/{bin,share}
rm -rf $HOME/.local/share/ubuntu-server-sync
git clone https://github.com/goransimicdev/ubuntu-server-sync.git $HOME/.local/share/ubuntu-server-sync
ln -sf $HOME/.local/share/ubuntu-server-sync/sync.sh $HOME/.local/bin/ubuntu-server-sync
