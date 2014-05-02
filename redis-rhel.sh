#!/bin/bash

# set -x 
PATH=$PATH:/bin:/usr/bin:/usr/local/bin


export FACTER_FPM_REDIS_PORT="6390"
export FACTER_FPM_REDIS_VERSION="2.8.8"
export FACTER_FPM_EMAIL='sowen@adaptivecomputing.com'
export FACTER_FPM_ITTERATION="1"

export FACTER_FPM_REDIS_PWD=`pwd`
export FACTER_FPM_INSTALLDIR='/tmp/installdir'
export FACTER_FPM_REDIS_URL="http://download.redis.io/releases"
# export FACTER_FPM_NAME="redis-$FACTER_FPM_REDIS_PORT"

echo "Installing puppet"
yum install -y puppet

# Install prerequisits for fpm
echo "Attempting to install puppetlabs standard library"
puppet module install puppetlabs/stdlib --modulepath=/tmp/modules

echo "Attempting to install required packages"
puppet apply ./manifests/packages.pp --modulepath=/tmp/modules

echo "Attempting to install fpm"
gem install fpm
# Download and extract redis
echo "Downloading redis $FACTER_FPM_REDIS_VERSION"
mkdir -p $FACTER_FPM_INSTALLDIR
wget $FACTER_FPM_REDIS_URL/redis-$FACTER_FPM_REDIS_VERSION.tar.gz -O /tmp/redis-$FACTER_FPM_REDIS_VERSION.tar.gz
tar -xvf /tmp/redis-$FACTER_FPM_REDIS_VERSION.tar.gz -C /tmp
#cd /tmp/redis-$FACTER_FPM_REDIS_VERSION

# Compile and install redis
make hiredis jemalloc linenoise lua -C /tmp/redis-$FACTER_FPM_REDIS_VERSION/deps
PREFIX=$FACTER_FPM_INSTALLDIR/usr/local/ make -C /tmp/redis-$FACTER_FPM_REDIS_VERSION
PREFIX=$FACTER_FPM_INSTALLDIR/usr/local/ make install -C /tmp/redis-$FACTER_FPM_REDIS_VERSION
mkdir -p $FACTER_FPM_INSTALLDIR/etc/init.d/
mkdir -p $FACTER_FPM_INSTALLDIR/etc/redis/
mkdir -p $FACTER_FPM_INSTALLDIR/var/lib/redis/$FACTER_FPM_REDIS_PORT
mkdir -p $FACTER_FPM_INSTALLDIR/var/log/
# mkdir -p $FACTER_FPM_INSTALLDIR/var/log/redis
mkdir -p $FACTER_FPM_INSTALLDIR/var/run/redis/



# Retreive init script from online 
#wget https://gist.githubusercontent.com/spuder/9401395/raw -O /tmp/redis_$FACTER_FPM_REDIS_VERSION.erb

function configure () {

	export FACTER_FPM_OSFAMILY=$1
	# Apply init script
	puppet apply ./manifests/initscript.pp --modulepath=/tmp/modules

	# Apply configuration file
	puppet apply ./manifests/config.pp --modulepath=/tmp/modules
}


configure "RedHat"
echo "Generating RPM"
fpm -s dir -m $FACTER_FPM_EMAIL -C $FACTER_FPM_INSTALLDIR  -t rpm -n "redis-$FACTER_FPM_REDIS_PORT" -v "$FACTER_FPM_REDIS_VERSION" --iteration $FACTER_FPM_ITTERATION etc/ usr/ var/ 

configure "Debian"
echo "Generating deb"
fpm -s dir -m $FACTER_FPM_EMAIL -C $FACTER_FPM_INSTALLDIR  -t deb -n "redis-$FACTER_FPM_REDIS_PORT" -v "$FACTER_FPM_REDIS_VERSION" --iteration $FACTER_FPM_ITTERATION etc/ usr/ var/ 
