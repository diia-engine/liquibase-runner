package ua.diiaengine.controllers;

import javafx.application.Platform;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.TextArea;
import javafx.stage.FileChooser;
import javafx.stage.Stage;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import ua.diiaengine.AppContext;
import ua.diiaengine.LiquibaseRunner;
import ua.diiaengine.utils.DBTools;
import ua.diiaengine.utils.FilesTools;
import ua.diiaengine.utils.TextAreaAppender;

import java.io.File;
import java.net.URL;
import java.util.ResourceBundle;

@Slf4j
public class MainFormController implements Initializable {
    @Setter
    private Stage stage;
    private AppContext context;
    private FilesTools filesTools;
    private DBTools dbTools;

    @FXML
    private Button chooseFileButton;
    @FXML
    private Button processButton;
    @FXML
    private Button clearButton;
    @FXML
    private TextArea logArea;

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        context = AppContext.getInstance();
        filesTools = context.get(FilesTools.class);
        dbTools = context.get(DBTools.class);
        TextAreaAppender.setLogArea(logArea);
        logArea.setEditable(false);
        logArea.setFocusTraversable(false);
        chooseFileButton.setOnAction(e -> onChooseFile());
        processButton.setOnAction(e -> Platform.runLater(this::onProcess));
        clearButton.setOnAction(e -> onClear());
    }

    private void onProcess() {
        dbTools.initWorkerPool();
        chooseFileButton.setDisable(true);
        processButton.setDisable(true);
        clearButton.setDisable(true);
        LiquibaseRunner liquibaseRunner = context.get(LiquibaseRunner.class);
        liquibaseRunner.process(() -> {
            chooseFileButton.setDisable(false);
            clearButton.setDisable(false);
            dbTools.stopWorkerPool();
        });
    }

    private void onChooseFile() {
        FileChooser fileChooser = new FileChooser();
        fileChooser.setTitle("Обрати main-liquibase.xml");
        fileChooser.setInitialDirectory(new File(System.getProperty("user.home")));
        fileChooser.getExtensionFilters().add(
                new FileChooser.ExtensionFilter(FilesTools.MAIN_LIQUIBASE + " files", FilesTools.MAIN_LIQUIBASE)
        );
        File mainLiquibase = fileChooser.showOpenDialog(stage);
        if (mainLiquibase != null) {
            filesTools.setTargetMainLiquibase(mainLiquibase);
            filesTools.copyDirectoryRecursively();
            logger.info(mainLiquibase.getAbsolutePath());
            processButton.setDisable(false);
        }
    }

    private void onClear() {
        logArea.clear();
        processButton.setDisable(true);
        filesTools.deleteAllFilesInDirectory();
        dbTools.stopWorkerPool();
        dbTools.recreateDatabase();
    }
}
