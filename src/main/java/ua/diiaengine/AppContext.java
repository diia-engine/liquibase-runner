package ua.diiaengine;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.Setter;
import lombok.SneakyThrows;
import org.apache.commons.configuration2.Configuration;
import org.apache.commons.configuration2.FileBasedConfiguration;
import org.apache.commons.configuration2.builder.FileBasedConfigurationBuilder;
import ua.diiaengine.utils.FilesTools;

import java.nio.file.Path;

@Getter
@Setter
public class AppContext {
    private FileBasedConfigurationBuilder<FileBasedConfiguration> fileBasedConfigurationBuilder;
    private Path configPath;
    private FilesTools filesTools;
    private LiquibaseRunner liquibaseRunner;

    @Getter
    private static final AppContext instance = new AppContext();

    private AppContext() {}

    public String getConfigStringProperty(String prop) {
        checkConfigContainsProperty(prop);
        return getConfig().getString(prop);
    }

    private void checkConfigContainsProperty(String prop) {
        if (!getConfig().containsKey(prop)) throw new IllegalArgumentException("Property " + prop + " not found in config");
    }

    @SneakyThrows
    public Configuration getConfig() {
        return fileBasedConfigurationBuilder.getConfiguration();
    }
}
