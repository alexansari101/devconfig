#!/bin/bash

# Note: vscode is installed through the deb link online.
#       The scrip below only configures vscode.

echo "Copying vscode settings.json..."
PARENT_PATH=$(dirname $(realpath $0))
cp "$PARENT_PATH/vscode/settings.json" "$HOME/.config/Code/User/"

echo "done."

