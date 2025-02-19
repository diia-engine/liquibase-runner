mkdir dump_db
docker-compose up -d
java -jar target/liquibase-runner-0.1.0-SNAPSHOT-jar-with-dependencies.jar