#!/usr/bin/env bash

set -e
set -x
# We have to install new bsdtar since the ubuntu version is old
wget https://www.libarchive.org/downloads/libarchive-3.3.1.tar.gz
tar xzf libarchive-3.3.1.tar.gz
cd libarchive-3.3.1
./configure
make
make install
bsdtar --version
