FROM docker.io/library/postgres:14.20-bookworm

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        wget \
        postgresql-14-pgaudit \
        postgresql-14-postgis-3 \
        postgresql-14-postgis-3-scripts \
        openjdk-17-jre-headless && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/liquibase

COPY ./deploy/lib/ /opt/liquibase/lib/
COPY ./deploy/xml/ /data
COPY ./deploy/conf/postgres.conf /etc/postgresql/postgresql.conf
COPY ./deploy/conf/pg_hba.conf /etc/postgresql/pg_hba.conf
COPY ./deploy/sql/create_users.sql /docker-entrypoint-initdb.d/10_create_users.sql
COPY ./deploy/sql/create_camunda_db.sql /docker-entrypoint-initdb.d/20_create_camunda_db.sql
COPY ./deploy/sql/functions.sql /data/functions.sql
COPY ./deploy/sql/registry_template.sql /data/registry_template.sql
COPY ./deploy/sql/gis_functions.sql /data/gis_functions.sql
COPY ./deploy/sh/restore_registry_template.sh /docker-entrypoint-initdb.d/10_restore_registry_template.sh

RUN chmod +x /docker-entrypoint-initdb.d/10_restore_registry_template.sh
RUN chown -R postgres:postgres /opt/liquibase /data

USER postgres