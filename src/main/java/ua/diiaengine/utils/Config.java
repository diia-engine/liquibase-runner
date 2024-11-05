package ua.diiaengine.utils;

import java.util.Properties;

public class Config {
    public static String getStringProperty(Properties config, String prop) {
        checkConfigContainsProperty(config, prop);
        return config.getProperty(prop);
    }

    public static boolean getBooleanProperty(Properties config, String prop) {
        checkConfigContainsProperty(config, prop);
        return Boolean.parseBoolean(config.getProperty(prop));
    }

    public static int getIntegerProperty(Properties config, String prop) {
        checkConfigContainsProperty(config, prop);
        return Integer.parseInt(config.getProperty(prop));
    }

    private static void checkConfigContainsProperty(Properties config, String prop) {
        if (!config.containsKey(prop)) throw new IllegalArgumentException("Property " + prop + " not found in config");
    }
}
