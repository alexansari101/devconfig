#!/bin/bash

apt-get update && apt-get -y install \
    locales \
    git \
    git-lfs \
    wget \
    curl \
    unzip

# Generaete the en_US.UTF-8 in case the system does not have it.
locale-gen en_US.UTF-8

apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

echo "Copying .gitconfig..."
PARENT_PATH=$(dirname $(realpath $0))
cp "$PARENT_PATH/git/.gitconfig" "$HOME"

