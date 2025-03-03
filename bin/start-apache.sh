#!/bin/bash

# Enable required Apache modules if not already enabled
if ! apache2ctl -M 2>/dev/null | grep -q 'proxy_module'; then
    a2enmod proxy_fcgi setenvif 2>/dev/null
fi

# Disable all other PHP versions to avoid conflicts
for version in 8.0 8.1 8.2 8.3 8.4; do
    if [ "$version" != "$PHP_VERSION" ]; then
        a2dismod php${version} 2>/dev/null
    fi
done

# Enable the selected PHP version module
a2enmod php${PHP_VERSION} 2>/dev/null

# Update the PHP CLI alternative to the selected version
update-alternatives --set php /usr/bin/php${PHP_VERSION}

# Start the selected PHP-FPM service
service php${PHP_VERSION}-fpm start 2>/dev/null

# Restart Apache to apply the changes
service apache2 restart 2>/dev/null

# Provide an interactive bash shell
exec bash -i
