package ua.diiaengine;

import liquibase.Liquibase;
import liquibase.database.Database;
import liquibase.database.DatabaseFactory;
import liquibase.database.jvm.JdbcConnection;
import liquibase.exception.DatabaseException;
import liquibase.exception.LiquibaseException;
import liquibase.resource.FileSystemResourceAccessor;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import ua.diiaengine.utils.DBTools;
import ua.diiaengine.utils.FilesTools;

import java.io.File;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;

@Slf4j
public class LiquibaseRunner {
    @Setter
    private AppContext context;
    private DBTools DBTools;
    private FilesTools filesTools;
    private File sqlDir;
    private Map<String, File> fileList;

    public void init() {
        if (context == null) throw new IllegalArgumentException("Context is not provided");
        DBTools = context.get(DBTools.class);

        sqlDir = Paths.get(FilesTools.SQL_DIR).toFile();
        if (!sqlDir.exists()) throw new IllegalArgumentException("'sql' directory does not exist");

        filesTools = context.get(FilesTools.class);
        fileList = new HashMap<>();
        filesTools.readFilesRecursively(sqlDir, fileList);
    }

    public void process(Runnable runnable) {
        Thread thread = new Thread(() -> {
            DBTools.executeSQLScriptByLines(fileList.get("0_init_server.sql"));
            DBTools.executeSQLScriptFull(fileList.get("1_init_new_db.sql"));
            DBTools.executeSQLScriptFull(fileList.get("2_init_service_tables.sql"));
            filesTools.updateSchemaLocationInXMLFiles();
            logger.info("Starting Liquibase ...");
            try {
                runLiquibase();
                runnable.run();
            } catch (DatabaseException e) {
                logger.error(e.getMessage(), e);
            }
        });
        thread.start();
    }

    public void runLiquibase() throws DatabaseException {
        Database db = DatabaseFactory.getInstance().findCorrectDatabaseImplementation(new JdbcConnection(DBTools.getWorkerConnection()));
        FileSystemResourceAccessor fileSystemResourceAccessor = new FileSystemResourceAccessor(FilesTools.DATA_MODEL);
        try (Liquibase liquibase = new Liquibase(filesTools.getMainLiquibase().toString(), fileSystemResourceAccessor, db)) {
            liquibase.update("pub");
        } catch (LiquibaseException e) {
            logger.error(e.getMessage());
        }
    }
}
