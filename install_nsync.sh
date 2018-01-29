#!/bin/sh
cd /root/tensorflow/tensorflow/contrib/makefile/downloads/nsync/
mkdir /tmp/nsync
mkdir build_dir
cd build_dir
cmake -DCMAKE_INSTALL_PREFIX=/tmp/nsync/ ../
make
make install
