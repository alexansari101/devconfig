#!/bin/bash

# ask for password upfront
sudo -v

mkdir -p ~/.local/bin
mkdir -p ~/.local/src

# Basics
./scripts/apt-install.sh
./scripts/zsh-install.sh
./scripts/cargo-install.sh
./scripts/fzf-install.sh

# Extras
./scripts/miniconda-install.sh
./scripts/build-install.sh
./scripts/npm-install.sh
./scripts/tmux-install.sh
# ./scripts/neovim-install.sh
# ./scripts/llvm-install.sh
# ./scripts/ollama-install.sh
# ./scripts/github-cli-install.sh
# ./scripts/keepassxc-install.sh
# ./scripts/docker-install.sh
# ./scripts/docker-nvidia-container-toolkit-install.sh
# ./scripts/nix-pkgs-install.sh
