#!/usr/bin/env bash

#I think we only need to create the template
sudo su postgres -c "createdb template_postgis"
echo "SELECT VERSION();" | sudo su postgres -c "psql template_postgis"
sudo su postgres -c "echo 'CREATE EXTENSION postgis;' | psql template_postgis"
sudo su postgres -c "echo 'CREATE EXTENSION postgis_topology;' | psql template_postgis"
sudo su postgres -c "echo 'SELECT POSTGIS_FULL_VERSION();' | psql template_postgis"
sudo su postgres -c "echo 'GRANT ALL ON geometry_columns TO PUBLIC;' | psql template_postgis"
sudo su postgres -c "echo 'GRANT ALL ON spatial_ref_sys TO PUBLIC;' | psql template_postgis"


# sudo -u postgres pg_dumpall > /tmp/postgres.sql
# sudo -u postgres pg_dropcluster --stop 9.3 main
# sudo -u postgres pg_createcluster --locale en_US.UTF-8 --start 9.3 main
# sudo -u postgres psql -f /tmp/postgres.sql
#
# sudo -u postgres createuser --superuser root
# sudo -u postgres createdb root
#
# POSTGIS_SQL_PATH=`pg_config --sharedir`/contrib/postgis-2.0
# createdb -E UTF8 template_postgis
# createlang -d template_postgis plpgsql
# psql -d postgres -c \
#  "UPDATE pg_database SET datistemplate='true' WHERE datname='template_postgis'"
# psql -d template_postgis -f $POSTGIS_SQL_PATH/postgis.sql
# psql -d template_postgis -f $POSTGIS_SQL_PATH/spatial_ref_sys.sql
# psql -d template_postgis -f $POSTGIS_SQL_PATH/legacy.sql
# psql -d template_postgis -f $POSTGIS_SQL_PATH/rtpostgis.sql
# psql -d template_postgis -f $POSTGIS_SQL_PATH/topology.sql
# psql -d template_postgis -c "GRANT ALL ON geometry_columns TO PUBLIC;"
# psql -d template_postgis -c "GRANT ALL ON spatial_ref_sys TO PUBLIC;"
