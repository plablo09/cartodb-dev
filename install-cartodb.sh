#!/usr/bin/env bash -e
export USER=monkey
export SUBDOMAIN=$USER
export PASSWORD=monkey
export ADMIN_PASSWORD=monkey
export EMAIL=monkey@example.com

sudo cp config/* /usr/local/etc

cd setup
chmod u+x *.sh
sudo bash <<EOF
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

cd /usr/local/src/cartodb
bundle install

sudo pkill redis
sudo bundle exec foreman start -p 3000