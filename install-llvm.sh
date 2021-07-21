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

# NOTE: There are move llvm tools that may need stripping of the "-12"
#
# Install llvm-12. Note: there is also an apt repository alternative.
# Todo: clang-tidy-12 and ln -s as clang-tidy.
# See C++ llvm docker image example from https://pspdfkit.com/blog/2020/visual-studio-code-cpp-docker/
#
wget https://apt.llvm.org/llvm.sh \
    && chmod +x llvm.sh \
    && ./llvm.sh 12 \
    && ln -s /usr/bin/clangd-12 /usr/bin/clangd \
    && ln -s /usr/bin/lldb-12 /usr/bin/lldb \
    && ln -s /usr/bin/lldb-vscode-12 /usr/bin/lldb-vscode \
    && ln -s /usr/bin/lld-12 /usr/bin/lld \
    && ln -s /usr/bin/llc-12 /usr/bin/llc \
    && ln -s /usr/bin/clang-12 /usr/bin/clang \
    && ln -s /usr/bin/clang++-12 /usr/bin/clang++ \
    && ln -s /usr/bin/clang-cpp-12 /usr/bin/clang-cpp

apt-get autoremove -y && apt-get clean -y

# Set environment variables to use clang instead of CC
export LLVM_VERSION=12
export CC="/usr/bin/clang-${LLVM_VERSION}"
export CXX="/usr/bin/clang++-${LLVM_VERSION}"
export COV="/usr/bin/llvm-cov-${LLVM_VERSION}"
export LLDB="/usr/bin/lldb-${LLVM_VERSION}"

