package ua.diiaengine.utils;

import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import ua.diiaengine.AppContext;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;
import java.nio.file.attribute.BasicFileAttributes;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Stream;

@Slf4j
@Setter
public class FilesTools {
    private AppContext context;
    public static final String DATA_MODEL = "data-model";
    public static final String MAIN_LIQUIBASE = "main-liquibase.xml";
    public static final String SQL_DIR = "sql";

    @Getter
    private File mainLiquibase;

    public void init() throws IOException {
        if (context == null) throw new IllegalArgumentException("Context is not provided");
        Properties config = context.get(Properties.class);
        initDirectories();
        String sourceMainLiquibase = Config.getStringProperty(config, "source_main_liquibase");
        copyDirectoryRecursively(sourceMainLiquibase);
        mainLiquibase = Paths.get(DATA_MODEL, MAIN_LIQUIBASE).toFile();
        if (!mainLiquibase.exists()) throw new FileNotFoundException(mainLiquibase.getAbsolutePath());
    }

    private void initDirectories() {
        createDirectoryIfNotExists(Paths.get(DATA_MODEL));
        deleteAllFilesInDirectory(Paths.get(DATA_MODEL));
    }

    private void createDirectoryIfNotExists(Path path) {
        try {
            Files.createDirectories(path);
            logger.info("Directory has been found: {}", path.toAbsolutePath());
        } catch (IOException e) {
            throw new RuntimeException("Error creating directory: " + path.toAbsolutePath(), e);
        }
    }

    private void copyDirectoryRecursively(String sourceMainLiquibase) throws IOException {
        File src = new File(sourceMainLiquibase);
        if (src.isDirectory() || !src.exists() || !src.getName().contains(MAIN_LIQUIBASE)) {
            logger.warn("Source file must be '{}'! {}", MAIN_LIQUIBASE, src.getAbsolutePath());
            return;
        }

        logger.info("main-liquibase.xml found: {}", src.getAbsolutePath());
        logger.info("Copy files for processing...");

        Path sourceDir = Paths.get(src.getParent());
        Path targetDir = Paths.get(DATA_MODEL);
        Files.walkFileTree(sourceDir, new SimpleFileVisitor<Path>() {
            @Override
            public FileVisitResult visitFile(Path file, BasicFileAttributes attrs) throws IOException {
                Path targetPath = targetDir.resolve(sourceDir.relativize(file));
                Files.copy(file, targetPath, StandardCopyOption.REPLACE_EXISTING);
                return FileVisitResult.CONTINUE;
            }

            @Override
            public FileVisitResult preVisitDirectory(Path dir, BasicFileAttributes attrs) throws IOException {
                Path targetPath = targetDir.resolve(sourceDir.relativize(dir));
                Files.createDirectories(targetPath);
                return FileVisitResult.CONTINUE;
            }
        });
        logger.info("Copy files finished.");
    }

    public void deleteAllFilesInDirectory(Path path) {
        File directory = path.toFile();
        deleteAllFilesInDirectory(directory);
    }

    public void deleteAllFilesInDirectory(File directory) {
        if (directory.isDirectory()) {
            File[] files = directory.listFiles();
            if (files != null) {
                for (File file : files) {
                    if (file.isDirectory()) {
                        deleteAllFilesInDirectory(file);
                    }
                    file.delete();
                }
            }
        }
    }

    public void readFilesRecursively(File directory, Map<String, File> fileList) {
        File[] files = directory.listFiles();
        if (files != null) {
            for (File file : files) {
                if (file.isFile()) {
                    fileList.put(file.getName(), file);
                } else if (file.isDirectory()) {
                    readFilesRecursively(file, fileList);
                }
            }
        }
    }

    public void updateSchemaLocationInXMLFiles() {
        Path startPath = Paths.get(DATA_MODEL);
        try (Stream<Path> paths = Files.walk(startPath)) {
            paths
                    .filter(path -> Files.isRegularFile(path) && path.toString().endsWith(".xml"))
                    .forEach(this::processFile);
        } catch (IOException e) {
            logger.error("Error opening directory: {}", e.getMessage());
        }
    }

    private void processFile(Path file) {
        StringBuilder fileContent = new StringBuilder();

        String regex1 = "\\s\\S+dbchangelog-\\d\\.\\d\\.xsd";
        String regex2 = "\\s\\S+liquibase-ext-schema-latest\\.xsd";
        String regex3 = "\\s\\S+dbchangelog-ddm\\.xsd";

        Pattern pattern1 = Pattern.compile(regex1);
        Pattern pattern2 = Pattern.compile(regex2);
        Pattern pattern3 = Pattern.compile(regex3);

        try {
            List<String> lines = Files.readAllLines(file, StandardCharsets.UTF_8);
            try (BufferedWriter writer = Files.newBufferedWriter(file, StandardCharsets.UTF_8)) {
                for (String line : lines) {
                    Matcher matcher1 = pattern1.matcher(line);
                    Matcher matcher2 = pattern2.matcher(line);
                    Matcher matcher3 = pattern3.matcher(line);
                    if (matcher1.find()) {
                        line = line.replaceAll(regex1, " liquibase/dbchangelog-4.5.xsd");
                    }
                    if (matcher2.find()) {
                        line = line.replaceAll(regex2, " liquibase/dbchangelog-ddm.xsd");
                    }
                    if (matcher3.find()) {
                        line = line.replaceAll(regex3, " liquibase/dbchangelog-ddm.xsd");
                    }
                    fileContent.append(line).append(System.lineSeparator());
                }
                writer.write(fileContent.toString());
                logger.info("Schemas has been replaced in file: {}", file.getFileName());
            } catch (IOException e) {
                logger.error("Error during processing file {}: {}", file, e.getMessage());
            }
        } catch (IOException e) {
            logger.error("Error during processing file {}: {}", file, e.getMessage());
        }
    }
}
