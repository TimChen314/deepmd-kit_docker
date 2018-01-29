#!/bin/sh
alias cmake='cmake3'
cd /root
git clone https://github.com/deepmodeling/deepmd-kit.git deepmd-kit

cd $deepmd_source_dir/source
mkdir build 
cd build

cmake -DXDRFILE_ROOT=$xdrfile_root -DTENSORFLOW_ROOT=$tensorflow_root -DCMAKE_INSTALL_PREFIX=$deepmd_root ..
make -j20
make install
cp $deepmd_source_dir/data/raw/* $deepmd_root/bin/
ls $deepmd_root/bin
