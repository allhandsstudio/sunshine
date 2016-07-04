#!/bin/bash
#set -e

# ---------------------------------------------
# create and configure case
# ---------------------------------------------

# create the case template
python3 create_newcase.py
chmod a+x ./newcase.sh
./newcase.sh

# read the config files to create run-specific files
cd /var/cesm/case1
mkdir /var/cesm/inputdata
./cesm_setup

# set user-specified run variables
mv /set_user_vars.py .
python3 set_user_vars.py

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
# https://bb.cgd.ucar.edu/missing-ice-data:
aws s3 cp \
  s3://cesm-input-data/inputdata/ice/cice/iced.0001-01-01.gx1v6_20080212 \
  /var/cesm/inputdata/ice/cice/iced.0001-01-01.gx1v6_20080212
aws s3 cp \
  s3://cesm-input-data/inputdata/ice/cice/iced.0001-01-01.gx3v7_20080212 \
  /var/cesm/inputdata/ice/cice/iced.0001-01-01.gx3v7_20080212

./case1.run

/bin/bash
