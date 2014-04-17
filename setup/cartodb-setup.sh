#!/usr/bin/env bash

cd /usr/local/src/cartodb
bundle install

mv config/app_config.yml.sample config/app_config.yml
mv config/database.yml.sample config/database.yml

# get postgres to drop all security
mv /etc/postgresql/9.1/main/pg_hba.conf /etc/postgresql/9.1/main/pg_hba.conf.original
ln -s /usr/local/etc/pg_hba.conf /etc/postgresql/9.1/main/pg_hba.conf

/etc/init.d/postgresql restart

sleep 5s


echo "127.0.0.1 ${USER}.localhost.lan" | sudo tee -a /etc/hosts
export SUBDOMAIN=$USER
bundle exec rake rake:db:create
bundle exec rake rake:db:migrate
bundle exec rake cartodb:db:create_publicuser
bundle exec rake cartodb:db:create_user SUBDOMAIN="${USER}" PASSWORD="${PASSWORD}" EMAIL="${EMAIL}"
bundle exec rake cartodb:db:create_importer_schema
# or bundle exec rake cartodb:db:create_schemas ?
bundle exec rake cartodb:db:load_functions

export SUBDOMAIN=$USER
set -e # Abort on error
bundle exec rake cartodb:db:set_user_quota["${SUBDOMAIN}",10240]
bundle exec rake cartodb:db:set_unlimited_table_quota["${SUBDOMAIN}"]
bundle exec rake cartodb:db:set_user_private_tables_enabled["${SUBDOMAIN}",'true']
bundle exec rake cartodb:db:set_user_account_type["${SUBDOMAIN}",'[DEDICATED]']


# The included config files are way out of date and will cause you very much pain
#ln -s /usr/local/etc/cartodb.development.js /usr/local/src/CartoDB-SQL-API/config/environments/development.js
#ln -s /usr/local/etc/windshaft.development.js /usr/local/src/Windshaft-cartodb/config/environments/development.js

# Instead, just patch the current ones:

perl -p -i -e 's/^(module.exports.node_host).*$/\1 = '"''/g" /usr/local/src/CartoDB-SQL-API/config/environments/development.js
perl -p -i -e 's/^(    ,host:).*$/\1 '"''/g" /usr/local/src/Windshaft-cartodb/config/environments/development.js
perl -p -i -e 's/^(    ,mapnik_version:).*$/\1 '"'2.1.1'/g" /usr/local/src/Windshaft-cartodb/config/environments/development.js
