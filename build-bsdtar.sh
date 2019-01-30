#!/usr/bin/env bash

set -e
set -x
# We have to install new bsdtar since the ubuntu version is old

if [[ ! -d ./libarchive-3.3.1 || ! -f ./libarchive-3.3.1/Makefile ]]; then
  wget https://www.libarchive.org/downloads/libarchive-3.3.1.tar.gz;
  tar xzf libarchive-3.3.1.tar.gz
  cd libarchive-3.3.1
  ./configure
  make
else
  cd libarchive-3.3.1
fi
make install
bsdtar --version
