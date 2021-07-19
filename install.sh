#!/bin/sh

set -e

PARENT_PATH=$(dirname $(realpath $0))

echo "Linking .tmux.conf..."
ln -sf "$PARENT_PATH/tmux/.tmux.conf" "$HOME"

echo "Linknig zsh configuration..."
ln -sf $PARENT_PATH/zsh/.zshrc $HOME
ln -sf $PARENT_PATH/zsh/.p10k.zsh $HOME

echo "Writing .vimrc..."
ln -sf $PARENT_PATH/vimrcs/.vimrc $HOME

echo "Writing init.vim..."
mkdir -p $HOME/.config/
ln -sf $PARENT_PATH/.config/nvim $HOME/.config/

echo "Done."

