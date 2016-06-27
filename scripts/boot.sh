#!/bin/bash
#set -e

# ---------------------------------------------
# fill in generic config variables
# ---------------------------------------------
./confd -onetime -backend env

# ---------------------------------------------
# create and configure case
# ---------------------------------------------

# create the case template
chmod a+x ./newcase.sh
./newcase.sh

# read the config files to create run-specific files
cd /var/cesm/case1
mkdir /var/cesm/inputdata
./cesm_setup

# ---------------------------------------------
# build case
# ---------------------------------------------
ln -s /usr/bin/make /usr/bin/gmake
./case1.build

# ---------------------------------------------
# start openalava and run case
# ---------------------------------------------
. /etc/profile.d/openlava.sh
service openlava start
ln -s /usr/libnetcdff.so.6 /usr/lib/libnetcdff.so.6
ln -s /usr/libnetcdf.so.11 /usr/lib/libnetcdf.so.11
ulimit -s unlimited
# ./case1.run

# ---------------------------------------------
# save results to s3
# ---------------------------------------------

/bin/bash
