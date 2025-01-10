# Project Manager Bash

This repository contains bash scripts for managing PHP and Python projects using Podman or Docker containers.

## Requirements

- Podman or Docker installed on your system.
- A network for Podman/Docker containers. You can create a network using the following command:
  ```bash
  podman network create container-network
  # or
  docker network create container-network
  ```

## PHP Projects

The `php-projects` script helps you manage PHP projects. It allows you to select a PHP version and run a containerized environment for your project.

### Usage

1. Make sure the `SCAN_DIR` variable in the script is set to the directory containing your PHP projects.
2. Run the script:
   ```bash
   ./php-projects
   ```
3. Select a project directory and PHP version when prompted.

## Python Projects

The `python-projects` script helps you manage Python projects. It allows you to select a Python version and run a containerized environment for your project.

### Usage

1. Make sure the `SCAN_DIR` variable in the script is set to the directory containing your Python projects.
2. Run the script:
   ```bash
   ./python-projects
   ```
3. Select a project directory and Python version when prompted.

## Additional Information

- The scripts use [fzf](https://github.com/junegunn/fzf) for interactive selection of project directories and versions.
- The scripts rely on `yq` for YAML processing in the Python projects.

## Contributing

Feel free to open issues or submit pull requests for improvements and bug fixes.
