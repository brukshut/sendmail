#!/bin/bash

##
## build openssl
##
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
NAME=openssl
VERSION=1.0.2o
URL=https://www.openssl.org/source/${NAME}-${VERSION}.tar.gz
CC=/usr/bin/gcc
CXX=/usr/bin/g++
LD=/usr/bin/ld
AS=/usr/bin/as
AR=/usr/bin/ar
export PATH CC CXX LD AS AR

wget $URL
tar xzvf ${NAME}-${VERSION}.tar.gz
cd ${NAME}-${VERSION}
./config --prefix=/usr/local
/usr/bin/make -j2
/usr/bin/make install
cd .. && rm -rf ${NAME}-${VERSION}*

