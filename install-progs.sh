#!/bin/bash

# ask for password upfront
sudo -v

apt-get update && apt-get -y install \
    build-essential \
    git \
    git-lfs \
    tig \
    silversearcher-ag \
    ripgrep \
    wget \
    curl \
    fd-find \
    zsh \
    tmux \
    stow \
    vim

mkdir -p ~/.local/bin
ln -s $(which fdfind) ~/.local/bin/fd


# TODO: Install bat.
# Ubuntu 20.04 -- there is a conflict with shared lib in crates2.json between bats and ripgrep that prevent installation of both through `apt`.
# Install deb package:
# dpkg -i bat_0.18.1_amd64.deb  # adapt version number and architecture

apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# Make zsh your default shell:
# chsh -s $(which zsh)
# ~/anaconda3/bin/conda init zsh

# install oh-my-zsh
echo "Installing oh-my-zsh..."
echo "N" | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# Install plugins
echo "Installing oh-my-zsh plugins..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions

echo "Installing vim plugins..."
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.vim/pack/plugins/start/fzf
git clone https://github.com/junegunn/fzf.vim.git ~/.vim/pack/plugins/start/fzf.vim
~/.vim/pack/plugins/start/fzf/install

