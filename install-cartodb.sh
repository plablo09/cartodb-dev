#!/usr/bin/env bash -e

sudo cp config/* /usr/local/etc

cd setup
chmod u+x *.sh
sudo bash <<EOF
source settings
./deb-deps.sh
./fetch-sources.sh
./postgis-install.sh
./postgis-setup.sh
./python-deps.sh
./node-deps.sh
./ruby-deps.sh
./cartodb-setup.sh 
EOF


sudo nohup redis-server &
source settings # Probably not needed
cd /usr/local/src/cartodb
bundle install

sudo pkill redis
sudo bundle exec foreman start -p 3000