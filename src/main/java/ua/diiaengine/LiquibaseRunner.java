package ua.diiaengine;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import ua.diiaengine.utils.FilesTools;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.StringJoiner;

@Slf4j
public class LiquibaseRunner {
    @Setter
    private AppContext context;
    private FilesTools filesTools;
    public String databaseDriver;
    public String databaseUrl;
    public String liquibaseClasspath;
    public String liquibaseJar;
    public String liquibaseMainScript;
    public String preDeployScript;
    private Map<String, File> fileList;

    public void init() {
        if (context == null) throw new IllegalArgumentException("Context is not provided");

        databaseDriver = context.getConfigStringProperty("database.driver");
        databaseUrl = context.getConfigStringProperty("database.url");
        liquibaseClasspath = new StringJoiner(":")
                .add(context.getConfigStringProperty("lib.postgresql"))
                .add(context.getConfigStringProperty("lib.liquibase_ddm_ext"))
                .add(context.getConfigStringProperty("lib.jackson_databind"))
                .add(context.getConfigStringProperty("lib.jackson_core"))
                .add(context.getConfigStringProperty("lib.jackson_annotations"))
                .toString();
        liquibaseJar = context.getConfigStringProperty("lib.liquibase");
        liquibaseMainScript = context.getConfigStringProperty("xml.liquibase_main_script");
        preDeployScript = context.getConfigStringProperty("xml.pre_deploy_script");

        File sqlDir = new File(context.getConfigStringProperty("sql_dir"));
        if (!sqlDir.exists()) throw new IllegalArgumentException("'sql' directory does not exist");

        filesTools = context.getFilesTools();
        fileList = new HashMap<>();
        filesTools.readFilesRecursively(sqlDir, fileList);
    }

    public void process(Runnable runnable) {
        Thread thread = new Thread(() -> {
            String dbName = context.getConfigStringProperty("database.name");
            String userName = context.getConfigStringProperty("database.username");
            runProcess(new String[]{
                    "psql", "-U", userName, "-d", "postgres", "-f", fileList.get("create_users.sql").getAbsolutePath()
            });
            runProcess(new String[]{
                    "psql", "-U", userName, "-d", "postgres", "-f", fileList.get("registry_template.sql").getAbsolutePath()
            });

            filesTools.copyDataLoad();

            runProcess(new String[]{"dropdb", "-f", dbName, "-U", userName});
            runProcess(new String[]{"createdb", "-T", "registry_template", dbName, "-U", userName});

            filesTools.updateSchemaLocationInXMLFiles();
            logger.info("Starting Liquibase ...");
            try {
                runLiquibase();
            } catch (Exception e) {
                logger.error(e.getMessage(), e);
            } finally {
                runnable.run();
            }
        });
        thread.start();
    }

    public void runLiquibase() {
        String dbName = context.getConfigStringProperty("database.name");
        String username = context.getConfigStringProperty("database.username");
        String[] commands = new String[]{
                "psql", "-U", username, "-d", dbName, "-c", "alter database " + dbName + " set search_path to '" + username + "', registry, public;"
        };
        runProcess(commands);
        logger.info("Run pre-deploy script");
        runUpdateLiquibase(preDeployScript, "all,pub");
        logger.info("Run main-deploy script");
        runUpdateLiquibase(liquibaseMainScript, "all,pub,code-review");
    }

    private void runUpdateLiquibase(String changeLogFile, String contexts) {
        String dbName = context.getConfigStringProperty("database.name");
        runProcess(new String[]{
                "java",
                "-jar",
                liquibaseJar,
                "--liquibaseSchemaName=public",
                "--classpath=" + liquibaseClasspath,
                "--driver=" + databaseDriver,
                "--changeLogFile=" + changeLogFile,
                "--url=" + databaseUrl + dbName,
                "--username=bamboo",
                "--password=bamboo",
                "--contexts=" + contexts,
                "--databaseChangeLogTableName=ddm_db_changelog",
                "--databaseChangeLogLockTableName=ddm_db_changelog_lock",
                "--logLevel=INFO",
                "update",
        });
    }

    private void runProcess(String[] commands) {
        logger.info("Running commands: {}", Arrays.toString(commands));
        try {
            Process process = Runtime.getRuntime().exec(commands);
            Thread stdoutThread = new Thread(() -> {
                try (BufferedReader stdoutReader = new BufferedReader(new InputStreamReader(process.getInputStream()))) {
                    String line;
                    while ((line = stdoutReader.readLine()) != null) {
                        logger.info(line);
                    }
                } catch (Exception e) {
                    logger.error("Error reading stdout", e);
                }
            });

            Thread stderrThread = new Thread(() -> {
                try (BufferedReader stderrReader = new BufferedReader(new InputStreamReader(process.getErrorStream()))) {
                    String line;
                    while ((line = stderrReader.readLine()) != null) {
                        logger.error(line);
                    }
                } catch (Exception e) {
                    logger.error("Error reading stderr", e);
                }
            });

            stdoutThread.start();
            stderrThread.start();

            int exitCode = process.waitFor();
            stdoutThread.join();
            stderrThread.join();

            if (exitCode != 0) {
                throw new RuntimeException("Error running Liquibase");
            }
        } catch (Exception e) {
            throw new RuntimeException("Error running process", e);
        }
    }
}
