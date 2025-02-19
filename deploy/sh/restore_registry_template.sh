#!/bin/bash
set -x

# Variables
DB=registry_template
USER=postgres

echo 'creating database' $DB
createdb $DB
echo 'creating functions on database' $DB
psql -U $USER $DB < /data/functions.sql
echo 'restoring database structure'
psql -U $USER $DB < /data/registry_template.sql