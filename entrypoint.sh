#!/bin/bash

# Start PHP-FPM
php-fpm &

# Start Apache
httpd -D FOREGROUND
