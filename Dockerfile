From centos:7
LABEL maintainer "Tim Chen timchen314@163.com"
# For now, only CentOS-Base.repo (USTC source, only users in China mainland should use it) and bazel.repo are in 'repo' directory. 
COPY repo/*repo /etc/yum.repos.d/
# Add additional source to yum
RUN yum makecache && yum install -y epel-release \
    centos-release-scl 
RUN rpm --import /etc/pki/rpm-gpg/RPM*
# bazel, gcc, gcc-c++ and path are needed by tensorflow;   
# autoconf, automake, cmake, libtool, make, wget are needed for protobut et. al.;  
# epel-release, cmake3, centos-release-scl, devtoolset-4-gcc*, scl-utils are needed for deepmd-kit(need gcc5.x);
# unzip are needed by download_dependencies.sh.
RUN yum install -y automake \
    autoconf \
    bzip \
    bazel \
    cmake \
    cmake3 \
    devtoolset-4-gcc* \
    git \
    gcc \
    gcc-c++ \
    libtool \
    make \
    patch \
    scl-utils \
    unzip \
    vim \
    wget
ENV tensorflow_root=/opt/tensorflow xdrfile_root=/opt/xdrfile \
    deepmd_root=/opt/deepmd deepmd_source_dir=/root/deepmd-kit
# If download lammps with git, there will be errors during installion. Hence we'll download lammps later on.
RUN cd /root && \
    git clone https://github.com/deepmodeling/deepmd-kit.git deepmd-kit && \
    git clone https://github.com/tensorflow/tensorflow tensorflow && \
    cd tensorflow && git checkout r1.4
# install tensorflow C lib
COPY install_input /root/tensorflow
RUN cd /root/tensorflow && ./configure < install_input &&  bazel build -c opt \
    --incompatible_load_argument_is_label=false \
    --copt=-msse4.2 --verbose_failures //tensorflow:libtensorflow_cc.so 
# install the dependencies of tensorflow and xdrfile
COPY install*.sh copy_lib.sh /root/
RUN cd /root/tensorflow && tensorflow/contrib/makefile/download_dependencies.sh && \
    cd /root && sh -x install_protobuf.sh && sh -x install_eigen.sh && \
    sh -x install_nsync.sh && sh -x copy_lib.sh && sh -x install_xdrfile.sh 
# `source /opt/rh/devtoolset-4/enable` to set gcc version to 5.x, which is needed by deepmd-kit.
# install deepmd
RUN cd /root && source /opt/rh/devtoolset-4/enable && \ 
    sh -x install_deepmd.sh
# install lammps
RUN cd /root && wget https://codeload.github.com/lammps/lammps/tar.gz/patch_31Mar2017 && \
    tar xf patch_31Mar2017 && source /opt/rh/devtoolset-4/enable && sh -x install_lammps.sh
# install tensorflow in python3 module
RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    sh Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda3/ && \
    conda create -n tensorflow python=3 && \
    conda config --add channels conda-forge && \
    conda install -c conda-forge tensorflow 
CMD ["/bin/bash"]
