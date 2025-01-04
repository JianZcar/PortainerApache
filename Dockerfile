# Use the latest Ubuntu image
FROM ubuntu:latest

# Set the environment variable for the PHP version, default to 8.2
ARG PHP_VERSION=8.2
ENV PHP_VERSION=${PHP_VERSION}

# Install required dependencies and PHP versions
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:ondrej/php && \
    apt-get update && \
    apt-get install -y apache2 php8.0 php8.0-fpm libapache2-mod-php8.0 php8.0-mysql \
                        php8.1 php8.1-fpm libapache2-mod-php8.1 php8.1-mysql \
                        php8.2 php8.2-fpm libapache2-mod-php8.2 php8.2-mysql \
                        php8.3 php8.3-fpm libapache2-mod-php8.3 php8.3-mysql \
                        php8.4 php8.4-fpm libapache2-mod-php8.4 php8.4-mysql && \
    apt-get clean

# Enable required Apache modules
RUN a2enmod proxy_fcgi setenvif

# Set ServerName to suppress the warning
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Copy the start script to the container
COPY start-apache.sh /usr/local/bin/start-apache.sh
RUN chmod +x /usr/local/bin/start-apache.sh

# Set the working directory
WORKDIR /var/www/html

# Expose port 80 for Apache
EXPOSE 80

# Set the entrypoint to the start script
ENTRYPOINT ["/usr/local/bin/start-apache.sh"]
