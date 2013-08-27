#!/usr/bin/env bash

cd /usr/local/src
wget http://download.osgeo.org/postgis/source/postgis-2.0.2.tar.gz
tar xzf postgis-2.0.2.tar.gz
cd postgis-2.0.2
./configure --with-raster --with-topology && make && make install

