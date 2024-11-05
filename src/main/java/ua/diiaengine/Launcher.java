package ua.diiaengine;

import lombok.extern.slf4j.Slf4j;
import org.slf4j.bridge.SLF4JBridgeHandler;
import ua.diiaengine.utils.DBTools;
import ua.diiaengine.utils.FilesTools;

import java.io.FileReader;
import java.util.Properties;

@Slf4j
public class Launcher {
    public static void main(String[] args) throws Exception {

        java.util.logging.LogManager.getLogManager().reset();
        SLF4JBridgeHandler.install();

        if (args.length == 0) throw new IllegalArgumentException("No config provided");
        Properties config = new Properties();
        config.load(new FileReader(args[0]));

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
