package ua.diiaengine;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import ua.diiaengine.utils.FilesTools;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.StringJoiner;

@Slf4j
public class LiquibaseRunner {
    @Setter
    private AppContext context;
    private FilesTools filesTools;
    private String databaseDriver;
    private String databaseUrl;
    private String liquibaseClasspath;
    private String liquibaseJar;
    private String liquibaseMainScript;
    private String preDeployScript;
    private String createDomainsScript;
    private String dbName;
    private String userName;
    private String password;
    private String containerName;
    private Runnable finalizer;

    public void init() {
        if (context == null) throw new IllegalArgumentException("Context is not provided");

        databaseDriver = context.getConfigStringProperty(Constants.DATABASE_DRIVER);
        databaseUrl = context.getConfigStringProperty(Constants.DATABASE_URL);
        liquibaseClasspath = new StringJoiner(":")
                .add(context.getConfigStringProperty(Constants.LIB_POSTGRESQL))
                .add(context.getConfigStringProperty(Constants.LIB_LIQUIBASE_DDM_EXT))
                .add(context.getConfigStringProperty(Constants.LIB_JACKSON_DATABIND))
                .add(context.getConfigStringProperty(Constants.LIB_JACKSON_CORE))
                .add(context.getConfigStringProperty(Constants.LIB_JACKSON_ANNOTATIONS))
                .toString();
        liquibaseJar = context.getConfigStringProperty(Constants.LIB_LIQUIBASE);
        liquibaseMainScript = context.getConfigStringProperty(Constants.XML_LIQUIBASE_MAIN_SCRIPT);
        preDeployScript = context.getConfigStringProperty(Constants.XML_PRE_DEPLOY_SCRIPT);
        createDomainsScript = context.getConfigStringProperty(Constants.XML_CREATE_DOMAINS_SCRIPT);
        dbName = context.getConfigStringProperty(Constants.DATABASE_NAME);
        userName = context.getConfigStringProperty(Constants.DATABASE_USERNAME);
        password = context.getConfigStringProperty(Constants.DATABASE_PASSWORD);
        containerName = context.getConfigStringProperty(Constants.DOCKER_CONTAINER_NAME);

        filesTools = context.getFilesTools();
    }

    public LiquibaseRunner setFinalizer(Runnable finalizer) {
        this.finalizer = finalizer;
        return this;
    }

    public void process() {
        Thread thread = new Thread(() -> {
            filesTools.copyDataLoad();
            filesTools.updateSchemaLocationInXMLFiles();
            execCommand("createdb -T registry_template " + dbName + " -U " + userName);
            execCommand("cp -r /data/dump_db/data-model/data-load/ /tmp/data-load/");

            logger.info("Starting Liquibase ...");
            try {
                runLiquibase();
            } catch (Exception e) {
                logger.error(e.getMessage(), e);
            } finally {
                if (finalizer != null) finalizer.run();
            }
        });
        thread.start();
    }

    public void runLiquibase() {
        execCommand("psql -c 'alter database " + dbName + " set search_path to \"" + userName + "\", registry, public;'");
        logger.info("Run pre-deploy script");
        runUpdateLiquibase(preDeployScript, "all,pub");
        runUpdateLiquibase(createDomainsScript, "all,pub");
        logger.info("Run main-deploy script");
        runUpdateLiquibase(liquibaseMainScript, "all,pub,code-review");
    }

    private void runUpdateLiquibase(String changeLogFile, String contexts) {
        execCommand(new StringJoiner(" ")
                .add("java")
                .add("-jar")
                .add(liquibaseJar)
                .add("--liquibaseSchemaName=public")
                .add("--classpath=" + liquibaseClasspath + ":/data/dump_db/")
                .add("--driver=" + databaseDriver)
                .add("--changeLogFile=" + changeLogFile)
                .add("--url=" + databaseUrl + "/" + dbName)
                .add("--username=" + userName)
                .add("--password=" + password)
                .add("--contexts=" + contexts)
                .add("--databaseChangeLogTableName=ddm_db_changelog")
                .add("--databaseChangeLogLockTableName=ddm_db_changelog_lock")
                .add("--logLevel=INFO")
                .add("update")
                .toString()
        );
    }

    private void execCommand(String command) {
        logger.info("Executing command: {}{}", "docker exec " + containerName + " bash -c ", command);
        try {
            ProcessBuilder builder = new ProcessBuilder("docker", "exec", containerName, "bash", "-c", command);
            builder.redirectErrorStream(true);
            Process process = builder.start();
            try (BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    logger.info(line);
                }
            }
            int exitCode = process.waitFor();
            logger.info("Exit code: {}", exitCode);
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }
    }
}
