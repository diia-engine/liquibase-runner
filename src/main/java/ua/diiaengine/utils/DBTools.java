package ua.diiaengine.utils;

import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import ua.diiaengine.AppContext;

import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

@Slf4j
public class DBTools {
    @Setter
    private AppContext context;
    private HikariCpPool pool;
    @Getter
    private String databaseName;
    @Getter
    private String username;
    @Getter
    private String password;

    public void init() {
        if (context == null) throw new IllegalArgumentException("Context is not provided");
        Properties config = context.get(Properties.class);
        databaseName = Config.getStringProperty(config, "database.name");
        username = Config.getStringProperty(config, "database.username");
        password = Config.getStringProperty(config, "database.password");

        dropDatabase();
        createDatabase();

        pool = new HikariCpPool();
        pool.setContext(context);
        pool.init();
    }

    public void shutdown() {
        pool.shutdown();
    }

    private void dropDatabase() {
        String systemDb = "jdbc:postgresql://localhost:5432/postgres";
        String dropDbQuery = "DROP DATABASE " + databaseName;

        try (Connection connection = DriverManager.getConnection(systemDb, username, password);
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
        String systemDb = "jdbc:postgresql://localhost:5432/postgres";
        String createDbQuery = "CREATE DATABASE " + databaseName;

        try (Connection connection = DriverManager.getConnection(systemDb, username, password);
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
            String dsn = "jdbc:postgresql://localhost:5432/" + databaseName + "?currentSchema=registry";
            context.get(Properties.class).put("database.dsn", dsn);
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
        try (Statement statement = pool.getConnection().createStatement()) {
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

    public Connection getConnection() {
        try {
            return pool.getConnection();
        } catch (SQLException e) {
            logger.error("Unable to get connection. Cause: {}", e.getMessage());
            throw new RuntimeException(e);
        }
    }
}
