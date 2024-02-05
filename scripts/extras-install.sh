#!/bin/bash

apt-get update && apt-get -y install tmux

apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

echo "Copying .tmux.conf..."
PARENT_PATH=$(dirname $(realpath $0))
cp "$PARENT_PATH/tmux/.tmux.conf" "$HOME"

echo "Installing keepassxc..."
snap install keepassxc

echo "Done."

