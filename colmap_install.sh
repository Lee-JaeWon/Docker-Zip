#!/bin/bash

apt-get update
apt-get install -y \
    git \
    cmake \
    ninja-build \
    build-essential \
    libboost-program-options-dev \
    libboost-filesystem-dev \
    libboost-graph-dev \
    libboost-system-dev \
    libeigen3-dev \
    libflann-dev \
    libfreeimage-dev \
    libmetis-dev \
    libgoogle-glog-dev \
    libgtest-dev \
    libgmock-dev \
    libsqlite3-dev \
    libglew-dev \
    qtbase5-dev \
    libqt5opengl5-dev \
    libcgal-dev \
    libceres-dev

mkdir -p ~/thirdParty && cd ~/thirdParty
git clone https://github.com/colmap/colmap.git
cd colmap
mkdir build
cd build

cmake .. -GNinja -DCMAKE_CUDA_ARCHITECTURES=75
ninja
ninja install

apt-get update
apt-get install -y imagemagick