package ua.diiaengine.utils;

import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import ua.diiaengine.AppContext;

import java.io.*;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

@Slf4j
public class DBTools {
    @Setter
    private AppContext context;
    private HikariCpPool workerPool;
    private HikariCpPool masterPool;
    @Getter
    private String databaseName;
    @Getter
    private String username;
    @Getter
    private String password;
    private String workerDsn;

    public void init() {
        if (context == null) throw new IllegalArgumentException("Context is not provided");
        Properties config = context.get(Properties.class);
        databaseName = Config.getStringProperty(config, "database.name");
        username = Config.getStringProperty(config, "database.username");
        password = Config.getStringProperty(config, "database.password");

        initMasterPool();
        recreateDatabase();
    }

    public void recreateDatabase() {
        dropDatabase();
        createDatabase();
    }

    private void initMasterPool() {
        masterPool = new HikariCpPool();
        masterPool.setContext(context);
        masterPool.setDsn("jdbc:postgresql://localhost:5432/postgres");
        masterPool.init();
    }

    public void initWorkerPool() {
        workerPool = new HikariCpPool();
        workerPool.setContext(context);
        workerPool.setDsn(workerDsn);
        workerPool.init();
    }

    public Connection getMasterConnection() {
        try {
            return masterPool.getConnection();
        } catch (SQLException e) {
            logger.error("Unable to get connection. Cause: {}", e.getMessage());
            throw new RuntimeException(e);
        }
    }

    public Connection getWorkerConnection() {
        try {
            return workerPool.getConnection();
        } catch (SQLException e) {
            logger.error("Unable to get connection. Cause: {}", e.getMessage());
            throw new RuntimeException(e);
        }
    }

    public void stopWorkerPool() {
        workerPool.shutdown();
    }

    public void stopMasterPool() {
        masterPool.shutdown();
    }

    private void dropDatabase() {
        String dropDbQuery = "DROP DATABASE " + databaseName;
        try (Connection connection = masterPool.getConnection();
             Statement statement = connection.createStatement()) {
            statement.executeUpdate(dropDbQuery);
            logger.info("Database {} has been deleted.", databaseName);
        } catch (SQLException e) {
            if (e.getSQLState().equals("3D000")) {
                logger.info("Database {} already exists.", databaseName);
            }
        }
    }

    private void createDatabase() {
        String createDbQuery = "CREATE DATABASE " + databaseName;
        try (Connection connection = masterPool.getConnection();
             Statement statement = connection.createStatement()) {
            statement.executeUpdate(createDbQuery);
            logger.info("Database {} has been created.", databaseName);
        } catch (SQLException e) {
            if (e.getSQLState().equals("42P04")) {
                logger.info("Database {} already exists.", databaseName);
            } else {
                logger.error("Error creating database: {}", e.getMessage());
            }
        } finally {
            workerDsn = "jdbc:postgresql://localhost:5432/" + databaseName + "?currentSchema=registry";
        }
    }

    public void executeSQLScriptFull(File file) {
        if (file == null || !file.exists()) {
            logger.error("File doesn't exists: {}", file);
            return;
        }
        StringBuilder sb = new StringBuilder();
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line).append("\n");
            }
        } catch (IOException e) {
            logger.error("Error reading script file: {}. {}", file, e.getMessage());
        }

        executeSQLScript(sb.toString(), file.getName());
    }

    public void executeSQLScriptByLines(File file) {
        if (file == null || !file.exists()) {
            logger.error("File doesn't exists: {}", file);
            return;
        }
        StringBuilder sb = new StringBuilder();
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
                if (line.endsWith(";")) {
                    executeSQLScript(sb.toString(), file.getName());
                    sb.setLength(0);
                }
            }
        } catch (IOException e) {
            logger.error("Error reading script file: {}. {}", file, e.getMessage());
        }
    }

    private void executeSQLScript(String sql, String fileName) {
        try (Statement statement = workerPool.getConnection().createStatement()) {
            if (!sql.isEmpty()) {
                statement.execute(sql);
                logger.info("Script {} successfully executed", fileName);
            }
        } catch (SQLException e) {
            if (e.getSQLState().equals("42710")) {
                logger.warn(e.getMessage());
            } else {
                logger.error("Error executing SQL script: {}", e.getMessage());
            }
        }
    }
}
