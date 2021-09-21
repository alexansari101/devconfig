#!/bin/bash

# ask for password upfront
sudo -v

apt-get update && apt-get -y install \
    cmake \
    cppcheck \
    valgrind \
    gdb \
    ninja-build \
    ccache \
    lsb-release \
    apt-transport-https \
    gnupg 

# Install bazel
curl -fsSL https://bazel.build/bazel-release.pub.gpg | gpg --dearmor > bazel.gpg \
    && mv bazel.gpg /etc/apt/trusted.gpg.d/ \
    && echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" | \
    tee /etc/apt/sources.list.d/bazel.list \
    && apt-get update && apt-get -y install bazel \
    && apt-get update && apt -y full-upgrade

# Install llvm
export LLVM_VERSION=12
# Fingerprint: 6084 F3CF 814B 57C1 CF12 EFD5 15CF 4D18 AF4F 7421
wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|apt-key add -
# LLVM
apt-get update && apt-get -y install libllvm-${LLVM_VERSION}-ocaml-dev libllvm${LLVM_VERSION} \
    llvm-${LLVM_VERSION} llvm-${LLVM_VERSION}-dev llvm-${LLVM_VERSION}-runtime
# Clang and co
apt-get -y install clang-${LLVM_VERSION} clang-tools-${LLVM_VERSION} libclang-common-${LLVM_VERSION}-dev \
    libclang-${LLVM_VERSION}-dev libclang1-${LLVM_VERSION} clangd-${LLVM_VERSION} python3-clang-${LLVM_VERSION} \
    clang-format-${LLVM_VERSION} clang-tidy-${LLVM_VERSION} 
# libfuzzer
apt-get -y install libfuzzer-${LLVM_VERSION}-dev
# lldb
apt-get -y install lldb-${LLVM_VERSION}
# lld (linker)
apt-get -y install lld-${LLVM_VERSION}
# libc++
apt-get -y install libc++-${LLVM_VERSION}-dev libc++abi-${LLVM_VERSION}-dev
# OpenMP
apt-get -y install libomp-${LLVM_VERSION}-dev
# libclc
apt-get -y install libclc-${LLVM_VERSION}-dev

apt-get autoremove -y && apt-get clean -y

# NOTE: There are move llvm tools that may need stripping of the "-12"
#
# Install llvm-12. Note: there is also an apt repository alternative.
# Todo: clang-tidy-12 and ln -s as clang-tidy.
# See C++ llvm docker image example from https://pspdfkit.com/blog/2020/visual-studio-code-cpp-docker/
#
ln -sf /usr/bin/clangd-${LLVM_VERSION} /usr/bin/clangd
ln -sf /usr/bin/lldb-${LLVM_VERSION} /usr/bin/lldb
ln -sf /usr/bin/lldb-vscode-${LLVM_VERSION} /usr/bin/lldb-vscode
ln -sf /usr/bin/lld-${LLVM_VERSION} /usr/bin/lld
ln -sf /usr/bin/llc-${LLVM_VERSION} /usr/bin/llc
ln -sf /usr/bin/clang-${LLVM_VERSION} /usr/bin/clang
ln -sf /usr/bin/clang++-${LLVM_VERSION} /usr/bin/clang++
ln -sf /usr/bin/clang-cpp-${LLVM_VERSION} /usr/bin/clang-cpp
ln -sf /usr/bin/clang-tidy-${LLVM_VERSION} /usr/bin/clang-tidy
ln -sf /usr/bin/clang-format-${LLVM_VERSION} /usr/bin/clang-format

# Set environment variables to use clang instead of CC
export CC="/usr/bin/clang-${LLVM_VERSION}"
export CXX="/usr/bin/clang++-${LLVM_VERSION}"
export COV="/usr/bin/llvm-cov-${LLVM_VERSION}"
export LLDB="/usr/bin/lldb-${LLVM_VERSION}"

# Install python code formatter
pip3 install black

# vim: set up coc-clangd extension
mkdir -p ~/.config/coc/extensions
cd ~/.config/coc/extensions
npm install coc-pyright coc-clangd coc-json coc-snippets --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod

# nvim: install language service provders for built-in lsp
mkdir "${HOME}/.npm-packages"
npm config set prefix "${HOME}/.npm-packages"
npm i -g pyright
npm i -g typescript typescript-language-server

