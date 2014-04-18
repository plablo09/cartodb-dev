#!/usr/bin/env bash -e

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

sudo pkill redis
sudo bundle exec foreman start -p 3000