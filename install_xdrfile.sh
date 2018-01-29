cd /root
wget ftp://ftp.gromacs.org/pub/contrib/xdrfile-1.1.4.tar.gz
tar xvf xdrfile-1.1.4.tar.gz
cd xdrfile-1.1.4
./configure --prefix=$xdrfile_root
make -j8
make install
