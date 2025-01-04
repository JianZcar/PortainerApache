# Use the latest Fedora image
FROM fedora:latest

# Install Apache and PHP-FPM
RUN dnf -y update && \
    dnf -y install httpd php-fpm php-cli php-pdo php-mysqlnd && \
    dnf clean all

# Create the directory for the PHP-FPM PID file
RUN mkdir -p /run/php-fpm && chown apache:apache /run/php-fpm

# Set ServerName to localhost
RUN echo "ServerName localhost" >> /etc/httpd/conf/httpd.conf

# Configure Apache to use PHP-FPM
COPY php-fpm.conf /etc/httpd/conf.d/php-fpm.conf

# Set DirectoryIndex to include index.php
RUN echo "DirectoryIndex index.php index.html" >> /etc/httpd/conf/httpd.conf

# Ensure /var/www/html exists and set permissions
RUN mkdir -p /var/www/html && chown -R apache:apache /var/www/html

# Copy the entrypoint script
COPY entrypoint.sh /usr/local/bin/

# Make the entrypoint script executable
RUN chmod +x /usr/local/bin/entrypoint.sh

# Expose port 80
EXPOSE 80

# Use the entrypoint script
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
