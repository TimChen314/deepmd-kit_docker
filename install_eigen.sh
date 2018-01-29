#!/bin/sh
cd /root/tensorflow/tensorflow/contrib/makefile/downloads/eigen/
mkdir /tmp/eigen
mkdir build_dir
cd build_dir
cmake -DCMAKE_INSTALL_PREFIX=/tmp/eigen/ ../
make install
