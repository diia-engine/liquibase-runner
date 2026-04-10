#!/bin/bash
set -x

# Variables
DB=registry_template
USER=postgres
#WORKING_DB=registry

echo 'creating database' $DB
createdb $DB
echo 'creating functions on database' $DB
psql -U $USER $DB < /data/functions.sql
echo 'restoring database structure'
psql -U $USER $DB < /data/registry_template.sql
echo 'creating additional gis functions on database'
psql -U $USER $DB < /data/gis_functions.sql

#createdb -T $DB $WORKING_DB -U $USER