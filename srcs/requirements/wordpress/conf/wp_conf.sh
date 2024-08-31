#!/bin/bash

sleep 10

# /var/www/#wordpress/wp-config-sample.php

# si le fichier de configuration wordpress n'existe pas refaire la configuration par cli WP-CLI
if [ ! -f "/var/www/wordpress/wp-config-sample.php" ]; then
    wp config create    --allow-root \
                        --dbname=$SQL_DATABASE \
                        --dbuser=$SQL_USER \
                        --dbpass=$SQL_PASSWORD \
                        --dbhost=mariadb:3306 --path='/var/www/wordpress'