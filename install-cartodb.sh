#!/usr/bin/env bash

sudo cp config/* /usr/local/etc
chmod u+x setup/*.sh
sudo bash <<EOF
source settings
setup/deb-deps.sh
setup/fetch-sources.sh
setup/postgis-install.sh
setup/postgis-setup.sh
setup/python-deps.sh
setup/node-deps.sh
setup/ruby-deps.sh
setup/cartodb-setup.sh 
EOF


sudo nohup redis-server &
source settings # Probably not needed
cd /usr/local/src/cartodb
bundle install

sleep 5s # Problem with user data getting lost from redis. Will this help?

sudo pkill redis-server

sudo foreman start -p 3000