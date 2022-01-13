#!/bin/sh

export PATH=$PATH:/tool/gcc_linaro/gcc-linaro-7.3.1-2018.05-x86_64_aarch64-linux-gnu/bin

export CROSS_COMPILER=aarch64-linux-gnu-
export CC=${CROSS_COMPILER}gcc
export LD=${CROSS_COMPILER}ld
export AR=${CROSS_COMPILER}ar
export STRIP=${CROSS_COMPILER}strip
export RANLIB=${CROSS_COMPILER}ranlib

if [ ! -f numactl-2.0.14.tar.gz ];then
	wget https://github.com/numactl/numactl/releases/download/v2.0.14/numactl-2.0.14.tar.gz
fi

tar -zxf numactl-2.0.14.tar.gz

if [ $? -ne 0 ];then
	exit 1；
fi

(cd ./numactl-2.0.14;./configure --target=aarch64-linux-gnu --host=aarch64-linux-gnu --build=x86_64-pc-linux-gnu --prefix=$(pwd)/../usr --enable-static;make;make install)

rm -rf numactl-2.0.14;

make CROSS_COMPILE=aarch64-linux-gnu-

unset PATH
unset CC
unset LD
unset AR
unset STRIP
unset RANLIB
