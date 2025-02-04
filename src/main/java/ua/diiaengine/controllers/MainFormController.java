package ua.diiaengine.controllers;

import javafx.application.Platform;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.ProgressBar;
import javafx.scene.control.TextArea;
import javafx.scene.control.TextField;
import javafx.stage.FileChooser;
import javafx.stage.Stage;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.configuration2.Configuration;
import org.apache.commons.configuration2.FileBasedConfiguration;
import org.apache.commons.configuration2.builder.FileBasedConfigurationBuilder;
import org.apache.commons.configuration2.ex.ConfigurationException;
import ua.diiaengine.AppContext;
import ua.diiaengine.LiquibaseRunner;
import ua.diiaengine.utils.FilesTools;
import ua.diiaengine.utils.TextAreaAppender;

import java.io.*;
import java.net.URL;
import java.util.ResourceBundle;

@Slf4j
public class MainFormController implements Initializable {
    @Setter
    private Stage stage;
    private AppContext context;
    private FilesTools filesTools;

    @FXML
    private TextField txtUsername;
    @FXML
    private TextField txtPassword;
    @FXML
    private Button saveCredentialsButton;
    @FXML
    private Button chooseFileButton;
    @FXML
    private Button processButton;
    @FXML
    private Button clearButton;
    @FXML
    private TextArea logArea;
    @FXML
    private ProgressBar progressBar = new ProgressBar(0);

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        context = AppContext.getInstance();
        filesTools = context.getFilesTools();
        TextAreaAppender.setLogArea(logArea);
        logArea.setEditable(false);
        logArea.setFocusTraversable(false);
        chooseFileButton.setOnAction(e -> onChooseFile());
        processButton.setOnAction(e -> Platform.runLater(this::onProcess));
        clearButton.setOnAction(e -> onClear());

        String username = context.getConfigStringProperty("database.username");
        txtUsername.setText(username);

        String password = context.getConfigStringProperty("database.password");
        txtPassword.setText(password);

        if (txtUsername.getText().isEmpty() || txtPassword.getText().isEmpty()) {
            disableButtons();
        }

        txtUsername.setOnKeyTyped(keyEvent -> {
            if (txtUsername.getText().isEmpty()) {
                disableButtons();
            } else {
                enableButtons();
            }
        });

        txtPassword.setOnKeyTyped(keyEvent -> {
            if (txtPassword.getText().isEmpty()) {
                disableButtons();
            } else {
                enableButtons();
            }
        });

        saveCredentialsButton.setOnAction(event -> {
            Configuration config = context.getConfig();
            config.setProperty("database.username", txtUsername.getText());
            config.setProperty("database.password", txtPassword.getText());

            FileBasedConfigurationBuilder<FileBasedConfiguration> fileBasedConfigurationBuilder = context.getFileBasedConfigurationBuilder();
            try {
                fileBasedConfigurationBuilder.save();
                enableButtons();
            } catch (ConfigurationException e) {
                logger.error(e.getMessage(), e);
            }
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
            processButton.setDisable(false);
            filesTools.setTargetMainLiquibase(mainLiquibase);
            filesTools.copyDirectoryRecursively();
            logger.info(mainLiquibase.getAbsolutePath());
        }
    }

    private void onProcess() {
        disableButtons();
        LiquibaseRunner liquibaseRunner = context.getLiquibaseRunner();

        liquibaseRunner.process(this::enableButtons);
        LiquibaseTask task = new LiquibaseTask(100);
        progressBar.setVisible(true);
        progressBar.progressProperty().bind(task.progressProperty());
    }

    private void onClear() {
        logArea.clear();
        processButton.setDisable(true);
        filesTools.deleteAllFilesInDirectory();
    }

    private void disableButtons() {
        chooseFileButton.setDisable(true);
        clearButton.setDisable(true);
        progressBar.setVisible(true);
    }

    private void enableButtons() {
        chooseFileButton.setDisable(false);
        clearButton.setDisable(false);
        progressBar.setVisible(false);
    }
}
