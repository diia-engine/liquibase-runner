package ua.diiaengine.utils;

import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import ua.diiaengine.AppContext;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;
import java.nio.file.attribute.BasicFileAttributes;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Stream;

@Slf4j
public class FilesTools {
    @Setter
    private AppContext context;
    public static final String DATA_MODEL = "dump_db/data-model";
    public static final String MAIN_LIQUIBASE = "main-liquibase.xml";

    private String xsdSchemaExt;
    private String xsdSchema;

    @Getter
    private Path mainLiquibase;
    @Getter @Setter
    private File targetMainLiquibase;

    public void init() {
        if (context == null) throw new IllegalArgumentException("Context is not provided");
        initDirectories();
        xsdSchemaExt = context.getConfigStringProperty("xsd.schema-ext");
        xsdSchema = context.getConfigStringProperty("xsd.schema");
    }

    private void initDirectories() {
        createDirectoryIfNotExists();
    }

    private void createDirectoryIfNotExists() {
        Path path = Paths.get(DATA_MODEL);
        try {
            Files.createDirectories(path);
            logger.info("Directory ready: {}", path.toAbsolutePath());
        } catch (IOException e) {
            throw new RuntimeException("Error creating directory: " + path.toAbsolutePath(), e);
        }
    }

    public String getExistsMainLiquibaseFilePath() {
        Path path = Paths.get(DATA_MODEL, MAIN_LIQUIBASE);
        if (Files.exists(path)) {
            return path.toAbsolutePath().toString();
        }
        return null;
    }

    public void copyDirectoryRecursively() {
        Path path = targetMainLiquibase.toPath();
        if (Files.isDirectory(path) || !Files.exists(path) || !path.toString().contains(MAIN_LIQUIBASE)) {
            logger.warn("Source file must be '{}'! {}", MAIN_LIQUIBASE, path);
            return;
        }

        logger.info("main-liquibase.xml found: {}", path);
        logger.info("Copy files for processing...");

        Path sourceDir = path.getParent();
        Path targetDir = Paths.get(DATA_MODEL);
        try {
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
            mainLiquibase = Paths.get(DATA_MODEL, MAIN_LIQUIBASE);
            if (!Files.exists(mainLiquibase)) throw new FileNotFoundException(mainLiquibase.toString());
            logger.info("Copy files finished.");
        } catch (IOException e) {
            logger.error(e.getMessage(), e);
        }
    }

    public void deleteAllFilesInDirectory() {
        Path path = Paths.get(DATA_MODEL);
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
                        line = line.replaceAll(regex1, " " + xsdSchema);
                    }
                    if (matcher2.find()) {
                        line = line.replaceAll(regex2, " " + xsdSchemaExt);
                    }
                    if (matcher3.find()) {
                        line = line.replaceAll(regex3, " " + xsdSchemaExt);
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

    public void copyDataLoad() {
        Path sourceDir = Paths.get(DATA_MODEL, "data-load");
        Path targetDir = Paths.get("/tmp", "data-load");
        try {
            if (Files.exists(sourceDir) && Files.isDirectory(sourceDir)) {
                logger.info("Source dir found: {}", sourceDir.toAbsolutePath());
                if (Files.exists(targetDir)) {
                    deleteDirectory(targetDir);
                    logger.info("Old copy has been deleted: {}", targetDir.toAbsolutePath());
                }
                copyDirectory(sourceDir, targetDir);
                logger.info("Target dir has been copied to {}", targetDir.toAbsolutePath());
            }
        } catch (IOException e) {
            logger.error(e.getMessage(), e);
        }
    }

    private void copyDirectory(Path source, Path target) throws IOException {
        Files.walkFileTree(source, new SimpleFileVisitor<Path>() {
            @Override
            public FileVisitResult preVisitDirectory(Path dir, BasicFileAttributes attrs) throws IOException {
                Files.createDirectories(target.resolve(source.relativize(dir)));
                return FileVisitResult.CONTINUE;
            }

            @Override
            public FileVisitResult visitFile(Path file, BasicFileAttributes attrs) throws IOException {
                Files.copy(file, target.resolve(source.relativize(file)), StandardCopyOption.REPLACE_EXISTING);
                return FileVisitResult.CONTINUE;
            }
        });
    }

    private void deleteDirectory(Path directory) throws IOException {
        Files.walkFileTree(directory, new SimpleFileVisitor<Path>() {
            @Override
            public FileVisitResult visitFile(Path file, BasicFileAttributes attrs) throws IOException {
                Files.delete(file);
                return FileVisitResult.CONTINUE;
            }

            @Override
            public FileVisitResult postVisitDirectory(Path dir, IOException exc) throws IOException {
                Files.delete(dir);
                return FileVisitResult.CONTINUE;
            }
        });
    }
}
