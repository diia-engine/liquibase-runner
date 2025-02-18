#!/bin/bash
set -x

# Variables
DB=registry_template
USER=postgres

createdb $DB
psql -U $USER $DB < /data/functions.sql
psql -U $USER $DB < /data/registry_template.sql