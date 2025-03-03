# PortainerApache

This project provides a containerized Apache environment with support for multiple PHP versions. It utilizes Podman for container management and fzf for interactive folder selection. The primary goal is to quickly set up and manage PHP projects in isolated containers with Apache.

## Prerequisites

- **Podman**: Ensure you have Podman installed on your system.
- **fzf**: Install fzf for interactive folder selection.

## Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/JianZcar/PortainerApache.git
   cd PortainerApache
   ```

2. Build the Docker image:
   ```sh
   ./build
   ```

## Usage

### Starting a Container

1. Run the `portainer-apache` script to select a project folder and start the container:
   ```sh
   ./bin/portainer-apache
   ```

2. Follow the prompts to select the PHP version and the folder to be used in the container.

3. The script will handle container creation, starting Apache, and providing an interactive bash shell.

### Apache Configuration

- The `start-apache.sh` script is used to configure Apache and PHP-FPM within the container.
- It enables the selected PHP version, configures Apache modules, and starts the PHP-FPM service.

## Dockerfile

The Dockerfile is based on the latest Ubuntu image and installs the required dependencies, including multiple PHP versions, Apache, Node.js, and other tools.

Key Features:
- Supports PHP versions 8.0 to 8.4.
- Configures Apache with the necessary modules.
- Installs additional tools like Node.js, npm, and ngrok.
- Sets up a colorized bash prompt and aliases for a better terminal experience.

## Scripts

- `bin/portainer-apache`: Main script to start the container with the selected project folder and PHP version.
- `bin/start-apache.sh`: Script to configure and start Apache with the selected PHP version.
- `build`: Script to build the Docker image using Podman.

## License

This project is licensed under the terms of the GNU General Public License v3.0. See the LICENSE file for details.

## Contributing

Contributions are welcome! Please fork the repository and create a pull request with your changes.

## Acknowledgements

Special thanks to the open-source community for providing the tools and libraries used in this project.

For any issues or questions, please open an issue on the [GitHub repository](https://github.com/JianZcar/PortainerApache/issues).

---

Feel free to customize the README further based on your specific needs and project details.
