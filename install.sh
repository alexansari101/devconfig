#!/bin/bash

# NOTE: Issues with (docker) terminal colors. 
#       Fix:
#       TERM=xterm-256color  # force 256 color mode.
#       alias tmux='tmux -u' # for utf8 support
#       OR run a docker command like this 
#       docker run --rm -it -v $PWD:/root/devconfig -e TERM=xterm-256color ubuntu:20.04
#       (See: https://stackoverflow.com/questions/33493456/docker-bash-prompt-does-not-display-color-output/34779089)

# ask for password upfront
sudo -v

apt-get update && apt-get -y install \
    locales \
    build-essential \
    htop \
    git \
    git-lfs \
    tig \
    tree \
    silversearcher-ag \
    ripgrep \
    wget \
    curl \
    fd-find \
    zsh \
    tmux \
    stow \
    vim

# Generaete the en_US.UTF-8 in case the system does not already have it.
locale-gen en_US.UTF-8

# Install latest (unstable) nightly version of neovim
# NOTE: This skips tzdata configuration and defaults to UTC instead of US, Pacific.
#       It may be worth using dpkg-reconfigure to later fix tzdata.
#
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends software-properties-common
add-apt-repository -y ppa:neovim-ppa/unstable
apt-get update && apt-get -y install neovim python3-dev python3-pip
python3 -m pip install --user --upgrade pynvim

mkdir -p ~/.local/bin
ln -s $(which fdfind) ~/.local/bin/fd

# Install latest bat.
# Ubuntu 20.04 has a conflict with shared lib in crates2.json between bats and ripgrep. 
# This prevents installation of both through `apt`. Install deb package. 
# Note: requires manual upgrade.
# dpkg -i bat_0.18.1_amd64.deb  # adapt version number and architecture
#
BAT_DEB_VERSION="$(curl -s https://api.github.com/repos/sharkdp/bat/releases/latest | grep -Po '"tag_name": "v\K.*?(?=")')"
wget -O "bat_${BAT_DEB_VERSION}_amd64.deb" "https://github.com/sharkdp/bat/releases/download/v${BAT_DEB_VERSION}/bat_${BAT_DEB_VERSION}_amd64.deb"
dpkg -i "bat_${BAT_DEB_VERSION}_amd64.deb"
rm -f "bat_${BAT_DEB_VERSION}_amd64.deb"

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

echo "Installing vim plugins..."
# vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# required by coc:
curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
apt-get update && apt-get install -y nodejs 
npm install --global yarn
# Configure nvim and install the plugins using vim-plug
PARENT_PATH=$(dirname $(realpath $0))
source $PARENT_PATH/install-dotfiles.sh
nvim --headless +PlugInstall +qa
nvim --headless "+CocInstall coc-pyright" +qa

apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# Make zsh your default shell:
chsh -s $(which zsh)
# ~/anaconda3/bin/conda init zsh

