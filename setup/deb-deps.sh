#!/usr/bin/env bash
# This takes care of installing dependencies required from debian repos.

export LANGUAGE="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

#Remove postgres and postgis just to be sure
apt-get -qq purge postgis* postgresql*

#if you have previous installations of postgres/postgis, uncomment this line:
#rm -Rf /var/lib/postgresql /etc/postgresql

#apt-get update

apt-get install -y python-software-properties

add-apt-repository -y ppa:cartodb/gis
add-apt-repository -y ppa:mapnik/v2.1.0
add-apt-repository -y ppa:cartodb/nodejs
add-apt-repository -y ppa:cartodb/redis
add-apt-repository -y ppa:cartodb/postgresql-9.3

#Maybe we need this later to build gdal?
#add-apt-repository -y ppa:ubuntugis/ubuntugis-unstable

apt-get update

apt-get install gdal-bin libgdal1-dev python-gdal
apt-get install postgresql-9.3-postgis-2.1 postgresql-plpython-9.3
apt-get install postgis
apt-get install -q unp zip ruby1.9.3 ruby1.9.1-dev python-pip ruby-rspec libicu-dev
apt-get install postgresql-contrib-9.3
apt-get install postgresql-server-dev-9.3
apt-get install mercurial 

#
# apt-get install -y make unp zip libgeos-c1 libgeos-dev gdal-bin libgdal1-dev libjson0 \
#   python-simplejson libjson0-dev proj-bin proj-data libproj-dev postgresql-9.3 \
#   postgresql-client-9.3 postgresql-contrib-9.3 postgresql-server-dev-9.3 \
#   postgresql-plpython-9.3 ruby1.9.1 ruby1.9.1-dev nodejs npm redis-server libmapnik-dev \
#   mapnik-utils python-mapnik git python-setuptools python-gdal gdal-bin libgdal1-dev
