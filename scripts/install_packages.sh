#!/bin/bash

##
## install_packages.sh
## libsasl2-dev --> sasl2 headers
## libdb5.3-dev --> berkeley db headers
##

PATH=/bin:/sbin:/usr/bin:/usr/sbin
DEBIAN_FRONTEND="noninteractive"

## install required packages
apt-get update -y
apt-get install build-essential -y
apt-get install make -y
apt-get install git -y
apt-get install wget -y
apt-get install emacs -y
apt-get install vim -y
apt-get install m4 -y
apt-get install man -y
apt-get install sudo -y

## for sendmail
sudo apt-get install m4 -y
sudo apt-get install man -y
sudo apt-get install libsasl2-dev -y
sudo apt-get install sasl2-bin -y
sudo apt-get install libdb5.3-dev -y
sudo apt-get install libpam0g-dev -y
