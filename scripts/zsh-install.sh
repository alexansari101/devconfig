#!/bin/bash

set -e

apt-get update && apt-get -y install zsh

apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# install oh-my-zsh
echo "Installing oh-my-zsh..."
echo "N" | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install plugins
echo "Installing oh-my-zsh plugins..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions

# Configure zsh
echo "Linking zsh configs..."
PARENT_PATH=$(dirname $(realpath $0))
cp $PARENT_PATH/zsh/.zshrc $HOME
cp $PARENT_PATH/zsh/.custom.zsh $HOME
cp $PARENT_PATH/zsh/.p10k.zsh $HOME

# Make zsh the default shell:
echo "Configuring zsh as default shell."
chsh -s $(which zsh)

echo "done."
