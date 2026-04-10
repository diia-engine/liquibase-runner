# liquibase-runner-platform
A Podman-based local setup for running Liquibase migrations.

## Prerequisites
- **Podman container engine** container engine installed locally.
- **Java 17+** installed on the host machine executing the Gradle commands.
- Podman configured with a minimum of **4GB RAM** and **6GB disk space**.

## Usage

### 1. Configuration and Building Images
- Navigate to the project root directory
- Set the **`REGISTRY_DIR`** variable in the **`.env`** file to point to the root directory of your Registry (e.g., `~/IdeaProjects/registries/registry-regulations`).
- *(Optional)* Configure the logging level via the **`LOG_LEVEL`** variable in the `.env` file (defaults to `INFO`).
- Build and set up the images by running:
    ```bash
  ./gradlew buildImages

### 2. Starting the Environment
- Start the required containers using:
    ```bash
    podman compose up

### 3. Executing Liquibase Migrations
- Apply the database changes by running: 
  ```bash
  ./gradlew liquibaseUpdate

> ⚠️ **NOTE on Volumes and Projects:**
>
> The **`PROJECT_PREFIX`** variable in the **`.env`** file is used to quickly switch between Podman volumes, allowing you to isolate data across different projects.
>
> **Warning:** Be very careful when running `podman compose down -v`. This command will destroy **all** volumes defined in the `docker-compose.yaml` file, effectively wiping data for **all `PROJECT_PREFIX` values** associated with it.