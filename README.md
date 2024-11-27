# liquibase-runner
Simple, compact tool for local testing Liquibase.

### Main features

- Completely copying `data-model` directory to project root
- Automatic replacement headers links to local `liquibase/dbchangelog-4.5.xsd` and `liquibase/dbchangelog-ddm.xsd`
- Automatic creation new database with name from `config.properties` file
- Deployment tables, `_hst` tables and system tables including `databasechangelog`, `databasechangeloglock` and `ddm_liquibase_metadata`

### Requirements
- Postgresql >= 15
- Java 1.8
- Intellij Idea

### Launch
- Specify params in `etc/config.properties` or custom config such as `database.name`, `database.username` and `database.password`
- Specify Program arguments in Run/Debug Configuration as path to config file. For example: `etc/my_config.properties`
- Run class `ua.diiaengine.Launcher`

The current version Tool will be running under IDE only. 