package ua.diiaengine;

import lombok.Getter;
import lombok.Setter;
import ua.diiaengine.utils.FilesTools;

import java.nio.file.Path;
import java.util.Properties;

@Getter
@Setter
public class AppContext {
    private Properties config;
    private Path configPath;
    private FilesTools filesTools;
    private LiquibaseRunner liquibaseRunner;

    @Getter
    private static final AppContext instance = new AppContext();

    private AppContext() {}

    public String getConfigStringProperty(String prop) {
        String property = config.getProperty(prop);
        if (property == null) {
            throw new IllegalArgumentException("Property " + prop + " not found in config");
        }
        return property;
    }
}
