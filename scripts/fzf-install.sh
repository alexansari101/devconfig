#!/bin/bash

echo "installing fzf..."
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.local/src/fzf
~/.local/src/fzf/install

echo "done."
