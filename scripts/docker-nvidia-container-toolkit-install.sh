#!/bin/bash

set -e

# Provide nvidia support for docker.
echo "Installing nvidia container toolkit..."
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

apt-get update
apt-get install -y nvidia-container-toolkit

echo "Configuring docker to use nvidia container toolkit..."
nvidia-ctk runtime configure --runtime=docker
systemctl restart docker

echo "Configuring container runtime for rootless docker..."
nvidia-ctk runtime configure --runtime=docker --config=$HOME/.config/docker/daemon.json
# Note: I may need to remove the --user to avoid an error.
systemctl --user restart docker
# Modify line: no-cgroups = false -> no-cgroups = true
sed -i 's/#no-cgroups = false/no-cgroups = true/' /etc/nvidia/container-runtime/config.toml

echo "Done."
