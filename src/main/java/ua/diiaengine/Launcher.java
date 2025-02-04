package ua.diiaengine;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.stage.Stage;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.configuration2.FileBasedConfiguration;
import org.apache.commons.configuration2.PropertiesConfiguration;
import org.apache.commons.configuration2.builder.FileBasedConfigurationBuilder;
import org.slf4j.bridge.SLF4JBridgeHandler;
import ua.diiaengine.controllers.MainFormController;
import ua.diiaengine.utils.FilesTools;

import java.io.File;

@Slf4j
public class Launcher extends Application {
    private AppContext context;

    public static void main(String[] args) {
        launch(args);
    }

    @Override
    public void start(Stage stage) throws Exception {
        java.util.logging.LogManager.getLogManager().reset();
        SLF4JBridgeHandler.install();

        context = AppContext.getInstance();
        FileBasedConfigurationBuilder<FileBasedConfiguration> config = getConfig();
        context.setFileBasedConfigurationBuilder(config);

        FilesTools filesTools = new FilesTools();
        filesTools.setContext(context);
        filesTools.init();
        context.setFilesTools(filesTools);

        LiquibaseRunner liquibaseRunner = new LiquibaseRunner();
        liquibaseRunner.setContext(context);
        liquibaseRunner.init();
        context.setLiquibaseRunner(liquibaseRunner);

        new MainFormController().setStage(stage);

        FXMLLoader formLoader = new FXMLLoader(Launcher.class.getResource(Constants.MAIN_FORM));
        Scene scene = new Scene(formLoader.load());

        stage.setScene(scene);
        stage.setTitle(Constants.TITLE);
        stage.setResizable(false);
        stage.show();
    }

    private FileBasedConfigurationBuilder<FileBasedConfiguration> getConfig() {
        File file = new File(Constants.CONFIG_PATH);
        org.apache.commons.configuration2.builder.fluent.Parameters config = new org.apache.commons.configuration2.builder.fluent.Parameters();
        return new FileBasedConfigurationBuilder<FileBasedConfiguration>(PropertiesConfiguration.class).configure(config.properties().setFile(file));
    }
}
