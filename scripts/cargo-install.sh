#!/bin/bash

set -e

PARENT_PATH=$(dirname $(realpath $0))

echo "Installing cargo toolchain through rustup..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo "Installing cargo binaries..."
cargo install du-dust fd-find bat exa procs bottom ripgrep broot zoxide tree-sitter-cli

echo "Done."

