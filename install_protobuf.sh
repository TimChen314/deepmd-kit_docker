#!/bin/sh
cd /root/tensorflow
mkdir /tmp/proto
cd tensorflow/contrib/makefile/downloads/protobuf/
./autogen.sh
./configure --prefix=/tmp/proto/
make -j20
make install
