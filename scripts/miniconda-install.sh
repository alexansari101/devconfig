#!/bin/bash

set -e

# Install miniconda
echo "Installing miniconda..."
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm -rf ~/miniconda3/miniconda.sh

# Init miniconda in bash and zsh shells
~/miniconda3/bin/conda init bash
~/miniconda3/bin/conda init zsh

echo "Done."

