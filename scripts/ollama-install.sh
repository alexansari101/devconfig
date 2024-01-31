#!/bin/bash

set -e

echo "Installing cargo toolchain through rustup..."
cd $HOME && curl https://ollama.ai/install.sh | sh
cd -

echo "Done."

