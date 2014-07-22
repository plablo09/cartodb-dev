#!/usr/bin/env bash
# Install CartoDB for a development environment.
# This script can be run from the Vagrantfile or manually. See the README.
sudo cp config/* /usr/local/etc
chmod u+x setup/*.sh
sudo bash <<EOF
source settings
setup/deb-deps.sh
setup/fetch-sources.sh
setup/postgres-setup.sh
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
sleep 2s
script/restore_redis
sleep 5s # Problem with user data getting lost from redis. Will this help?

sudo pkill redis-server
at + 1 minutes script/restore_redis
sudo foreman start -p 3000
