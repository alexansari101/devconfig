#!/bin/bash

set -e

echo "Installing nix package manager..."
sh <(curl -L https://nixos.org/nix/install) --daemon

echo "Done."
