#!/bin/sh
cd /root/tensorflow/
mkdir -p $tensorflow_root/lib
cp bazel-bin/tensorflow/libtensorflow_cc.so $tensorflow_root/lib/
cp bazel-bin/tensorflow/libtensorflow_framework.so $tensorflow_root/lib/
cp /tmp/proto/lib/libprotobuf.a $tensorflow_root/lib/
cp /tmp/nsync/lib/libnsync.a $tensorflow_root/lib/

mkdir -p $tensorflow_root/include/tensorflow
cp -r bazel-genfiles/* $tensorflow_root/include/
cp -r tensorflow/cc $tensorflow_root/include/tensorflow
cp -r tensorflow/core $tensorflow_root/include/tensorflow
cp -r third_party $tensorflow_root/include
cp -r /tmp/proto/include/* $tensorflow_root/include
cp -r /tmp/eigen/include/eigen3/* $tensorflow_root/include
cp -r /tmp/nsync/include/*h $tensorflow_root/include

cd $tensorflow_root/include
find . -name "*.cc" -type f -delete

rm -fr /tmp/proto /tmp/eigen /tmp/nsync
