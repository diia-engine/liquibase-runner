package ua.diiaengine.utils;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import lombok.Getter;
import lombok.Setter;
import ua.diiaengine.AppContext;

import java.sql.Connection;
import java.sql.SQLException;

public class HikariCpPool {
    @Setter
    private AppContext context;
    @Getter
    private HikariDataSource pool;
    @Setter
    private String dsn;

    public void init() {
        if (context == null) throw new IllegalArgumentException("Context is not provided");
        HikariConfig hikariConfig = new HikariConfig();
        hikariConfig.setJdbcUrl(dsn);
        hikariConfig.setUsername(context.getConfigStringProperty("database.username"));
        hikariConfig.setPassword(context.getConfigStringProperty("database.password"));
        pool = new HikariDataSource(hikariConfig);
    }

    public Connection getConnection() throws SQLException {
        if (pool != null) {
            return pool.getConnection();
        } else {
            throw new RuntimeException("Pool is not initialized");
        }
    }

    public void shutdown() {
        if (pool != null && pool.isRunning()) pool.close();
    }
}
