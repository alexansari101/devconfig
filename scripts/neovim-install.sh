#!/bin/bash

set -e

# Installing neovim latest from src.
# deps: ninja-build gettext cmake unzip curl
echo "Building neovim from src..."
NEOVIM_SRC_PATH="$HOME/.local/src"
mkdir -p $NEOVIM_SRC_PATH
git clone https://github.com/neovim/neovim git $NEOVIM_SRC_PATH
cd $NEOVIM_SRC_PATH/neovim
git checkout stable
make CMAKE_BUILD_TYPE=RelWithDebInfo && make install
cd -

# Configure neovim
echo "Installing neovim config files..."
git clone https://github.com/alexansari101/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim

echo "done."
