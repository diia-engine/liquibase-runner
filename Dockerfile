FROM postgres:14.3

RUN apt-get update && apt-get install -y --no-install-recommends \
        mc ca-certificates \
        postgresql-14-pgaudit \
        postgresql-14-postgis-3-dbgsym/bullseye-pgdg \
        postgresql-14-postgis-3-scripts/bullseye-pgdg \
        openjdk-11-jdk

COPY ./deploy/xsd/ /data
COPY ./deploy/lib/ /opt
COPY ./deploy/xml/ /data

COPY ./deploy/conf/postgres.conf /etc/postgresql/postgresql.conf
COPY ./deploy/conf/pg_hba.conf /etc/postgresql/pg_hba.conf
COPY ./deploy/sql/create_users.sql /docker-entrypoint-initdb.d/10_create_users.sql
COPY ./deploy/sql/functions.sql /data/functions.sql
COPY ./deploy/sql/registry_template.sql /data/registry_template.sql
COPY ./deploy/sh/restore_registry_template.sh /docker-entrypoint-initdb.d/10_restore_registry_template.sh
RUN chmod +x /docker-entrypoint-initdb.d/10_restore_registry_template.sh

USER postgres
