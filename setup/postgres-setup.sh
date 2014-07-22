#!/usr/bin/env bash

#Configure postgres to trust all local connections:
echo -e "local\tall\tall\ttrust\nhost\tall\tall\t127.0.0.1/32\ttrust\nhost\tall\tall\t::1/128\ttrust" |sudo tee /etc/postgresql/9.3/main/pg_hba.conf
service postgresql restart

#Install schema_triggers
hg clone https://bitbucket.org/malloclabs/pg_schema_triggers &&
    cd pg_schema_triggers && make && sudo make install && cd -

#Configure postgres to load schema_triggers:
echo "shared_preload_libraries = 'schema_triggers.so'" |
    sudo tee -a /etc/postgresql/9.3/main/postgresql.conf &&
    sudo service postgresql restart
