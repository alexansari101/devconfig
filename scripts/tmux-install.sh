#!/bin/bash

set -e

# install tmux and xsel for tmux-yank plugin
apt-get update && apt-get -y install tmux xsel

apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

echo "Copying .tmux.conf..."
PARENT_PATH=$(dirname $(realpath $0))
cp "$PARENT_PATH/tmux/.tmux.conf" "$HOME"

echo "Installing tmux package manager..."
mkdir -p ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "Done."
