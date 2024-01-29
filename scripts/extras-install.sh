#!/bin/bash

apt-get update && apt-get -y install \
    tmux \
    keepassxc

apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

echo "Linking .tmux.conf..."
PARENT_PATH=$(dirname $(realpath $0))
ln -sf "$PARENT_PATH/tmux/.tmux.conf" "$HOME"

