#!/bin/bash

apt-get update && apt-get -y install \
    build-essential \
    gettext \
    ninja-build \
    ccache \
    make \
    cmake \
    valgrind \
    cppcheck \
    gdb \
    lsb-release \
    apt-transport-https \
    gnupg 

