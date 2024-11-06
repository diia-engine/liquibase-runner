package ua.diiaengine;

import lombok.Getter;

import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

public class AppContext {
    private Map<Class<?>, Object> beans = new HashMap<>(); // className, bean

    public void add(Object instance) {
        beans.put(instance.getClass(), instance);
    }

    public <T> T get(Class<T> tClass) {
        return (T) beans.get(tClass);
    }

    public void init() {
        Properties config = get(Properties.class);
        if (config == null) throw new IllegalArgumentException("No config provided");
    }

    @Getter
    private static final AppContext instance = new AppContext();

    private AppContext() {}
}
