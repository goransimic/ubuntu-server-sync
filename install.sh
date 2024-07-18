#!/bin/bash

sudo apt update > /dev/null
sudo apt install -y git > /dev/null

echo "Installing Ubuntu Server Sync..."
mkdir -p $HOME/.local/{bin,share}
rm -rf $HOME/.local/bin/ubuntu-server-sync
rm -rf $HOME/.local/share/ubuntu-server-sync
git clone https://github.com/goransimicdev/ubuntu-server-sync.git $HOME/.local/share/ubuntu-server-sync > /dev/null
ln -s $HOME/.local/share/ubuntu-server-sync/sync.sh $HOME/.local/bin/ubuntu-server-sync > /dev/null
