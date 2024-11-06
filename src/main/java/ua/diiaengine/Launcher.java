package ua.diiaengine;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.stage.Stage;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.bridge.SLF4JBridgeHandler;
import ua.diiaengine.controllers.MainFormController;
import ua.diiaengine.utils.DBTools;
import ua.diiaengine.utils.FilesTools;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;
import java.util.Properties;

@Slf4j
public class Launcher extends Application {
    private static String configName;

    public static void main(String[] args) throws Exception {
        if (args.length == 0) throw new IllegalArgumentException("No config provided");
        configName = args[0];
        launch(args);
    }

    @Override
    public void start(Stage stage) throws Exception {
        java.util.logging.LogManager.getLogManager().reset();
        SLF4JBridgeHandler.install();

        Properties config = getConfig();

        AppContext context = AppContext.getInstance();
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

        LiquibaseRunner liquibaseRunner = new LiquibaseRunner();
        liquibaseRunner.setContext(context);
        liquibaseRunner.init();
        context.add(liquibaseRunner);

        Runtime.getRuntime().addShutdownHook(new Thread(DBTools::shutdown));

        new MainFormController().setStage(stage);

        FXMLLoader formLoader = new FXMLLoader(Launcher.class.getResource("main-form.fxml"));
        Scene scene = new Scene(formLoader.load());

        stage.setScene(scene);
        stage.setTitle("Liquibase runner");
        stage.setResizable(false);
        stage.show();
    }

    private Properties getConfig() throws IOException {
        Properties config = new Properties();
        List<String> lines = Files.readAllLines(Paths.get(configName));
        for (String line : lines) {
            if (line.isEmpty()) continue;
            String key = line.substring(0, line.indexOf('='));
            String value = line.substring(line.indexOf('=') + 1);
            config.put(key, value);
        }
        return config;
    }
}
