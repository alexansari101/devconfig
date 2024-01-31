#!/bin/bash

echo "Installing nodejs npm and npx..."
curl -fsSL https://deb.nodesource.com/setup_21.x | bash -
apt-get install -y nodejs

echo "Done."

