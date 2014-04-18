#!/bin/bash

PATH=$PATH:/bin:/usr/bin:/usr/local/bin

$FPM_REDIS_PORT="6390"
$FPM_REDIS_VERSION="2.8.8"
$FPM_EMAIL='sowen@adaptivecomputing.com'
$FPM_ITTERATION="1"

$FPM_INSTALLDIR='/tmp/installdir'
$FPM_REDIS_URL="http://download.redis.io/releases/"
$FPM_NAME="redis-$FPM_REDIS_PORT"

# Install prerequisits for fpm
yum install gcc rpm-build
yum install ruby-devel   #alternativly use rbenv or RVM to install ruby development libaries
yum install rubygems
gem install fpm
#fpm --help

# Download and extract redis
mkdir -p $FPM_INSTALLDIR
cd /tmp
wget $FPM_REDIS_URL/redis-$FPM_REDIS_VERSION.tar.gz -O /tmp/redis-$FPM_REDIS_VERSION.tar.gz
tar -xvf /tmp/redis-$FPM_REDIS_VERSION.tar.gz
cd /tmp/redis-$FPM_REDIS_VERSION

# Compile and install redis
PREFIX=$FPM_INSTALLDIR/usr/local/ make 
PREFIX=$FPM_INSTALLDIR/usr/local/ make install 
mkdir -p $FPM_INSTALLDIR/etc/init.d/
mkdir -p $FPM_INSTALLDIR/etc/redis/
mkdir -p $FPM_INSTALLDIR/var/lib/redis/$FPM_REDIS_PORT

