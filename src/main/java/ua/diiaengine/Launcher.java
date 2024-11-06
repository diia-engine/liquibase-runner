package ua.diiaengine;

import lombok.extern.slf4j.Slf4j;
import org.slf4j.bridge.SLF4JBridgeHandler;
import ua.diiaengine.utils.DBTools;
import ua.diiaengine.utils.FilesTools;

import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;
import java.util.Properties;

@Slf4j
public class Launcher {
    public static void main(String[] args) throws Exception {

        java.util.logging.LogManager.getLogManager().reset();
        SLF4JBridgeHandler.install();

        if (args.length == 0) throw new IllegalArgumentException("No config provided");
        Properties config = new Properties();
        List<String> lines = Files.readAllLines(Paths.get(args[0]));
        for (String line : lines) {
            String key = line.substring(0, line.indexOf('='));
            String value = line.substring(line.indexOf('=') + 1);
            config.put(key, value);
        }

        AppContext context = new AppContext();
        context.add(config);
        context.init();

        FilesTools filesTools = new FilesTools();
        filesTools.setContext(context);
        filesTools.init();
        context.add(filesTools);

        DBTools DBTools = new DBTools();
        DBTools.setContext(context);
        DBTools.init();
        context.add(DBTools);

        LiquibaseRunner processor = new LiquibaseRunner();
        processor.setContext(context);
        processor.init();
        processor.process();

        Runtime.getRuntime().addShutdownHook(new Thread(DBTools::shutdown));
    }
}
