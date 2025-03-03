# Use the latest Ubuntu image
FROM ubuntu:latest

# Set the environment variable for the PHP version, default to 8.2
ARG PHP_VERSION=8.2
ENV PHP_VERSION=${PHP_VERSION}

# Install required dependencies and PHP versions
RUN apt-get update && \
    apt-get install -y software-properties-common curl && \
    add-apt-repository ppa:ondrej/php && \
    apt-get update && \
    apt-get install -y apache2 php8.0 php8.0-fpm libapache2-mod-php8.0 php8.0-mysql php8.0-mbstring \
                        php8.1 php8.1-fpm libapache2-mod-php8.1 php8.1-mysql php8.1-mbstring \
                        php8.2 php8.2-fpm libapache2-mod-php8.2 php8.2-mysql php8.2-mbstring \
                        php8.3 php8.3-fpm libapache2-mod-php8.3 php8.3-mysql php8.3-mbstring \
                        php8.4 php8.4-fpm libapache2-mod-php8.4 php8.4-mysql php8.4-mbstring && \
    apt-get clean
    
RUN apt-get update && \
		apt-get install -y wl-clipboard libwayland-dev && \
		apt-get clean

# Enable required Apache modules
RUN a2enmod proxy_fcgi setenvif

# Set ServerName to suppress the warning
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Install Node.js and npm
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean

# Install Intelephense globally using npm
RUN npm install -g intelephense typescript-language-server typescript vscode-langservers-extracted @tailwindcss/language-server npm

RUN curl -sSL https://ngrok-agent.s3.amazonaws.com/ngrok.asc \
    | tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && \
echo "deb https://ngrok-agent.s3.amazonaws.com buster main" \
    | tee /etc/apt/sources.list.d/ngrok.list >/dev/null && \
		apt update && \
		apt install ngrok && \
    apt-get clean

RUN apt-get update && \
		apt-get install -y nvim && \
    apt-get clean

# Copy the start script to the container
COPY start-apache.sh /usr/local/bin/start-apache.sh
RUN chmod +x /usr/local/bin/start-apache.sh

# Set the working directory
WORKDIR /var/www/html

# Expose port 80 for Apache
EXPOSE 80

ENV TERM="xterm-256color" \
    COLORTERM="truecolor"

# Enable true color support
RUN echo "export PS1='\[\033[38;5;39m\]\u@\h \[\033[38;5;208m\]\w\[\033[0m\] $ '" >> /root/.bashrc \
    && echo "alias ls='ls --color=auto'" >> /root/.bashrc 

# Set the entrypoint to the start script
ENTRYPOINT ["/usr/local/bin/start-apache.sh"]
