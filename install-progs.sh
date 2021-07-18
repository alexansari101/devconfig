#!/bin/bash

# TODO: Issues with (docker) terminal colors. 
#       Fix:
#       TERM=xterm-256color  # force 256 color mode.
#       alias tmux='tmux -u' # for utf8 support
#       OR run a docker command like this 
#       docker run -it -v $PWD:/root/devconfig -e TERM=xterm-256color -e alias='tmux -u' ubuntu:20.04 script -q -c "/bin/bash" /dev/null
#       (See: https://stackoverflow.com/questions/33493456/docker-bash-prompt-does-not-display-color-output/34779089)
#
# TODO: Install vim coc plugin's extensions by script. E.g., vim "+CocInstall coc-pyright" +qa. Note: This doesnt work with the +qa.
#       Alternatively: consider copying/linking .config/coc/.

# ask for password upfront
sudo -v

apt-get update && apt-get -y install \
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
# gruvbox
git clone https://github.com/morhetz/gruvbox.git ~/.vim/pack/plugins/start/gruvbox
# vimwiki
git clone https://github.com/vimwiki/vimwiki.git ~/.vim/pack/plugins/start/vimwiki
# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.vim/pack/plugins/start/fzf
git clone https://github.com/junegunn/fzf.vim.git ~/.vim/pack/plugins/start/fzf.vim
~/.vim/pack/plugins/start/fzf/install --all
# coc
curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
apt-get install -y nodejs 
npm install --global yarn
git clone https://github.com/neoclide/coc.nvim.git ~/.vim/pack/plugins/start/coc.nvim

apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

