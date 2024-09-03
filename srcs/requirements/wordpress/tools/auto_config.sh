#!/bin/bash

sleep 20

#Attendre que la base de données soit prête
until mysqladmin ping -h mariadb --silent; do
    echo "Waiting for MariaDB to be ready..."
    sleep 5
done

# Vérifier si wp-config.php existe, sinon le créer
if [ ! -f /var/www/wordpress/wp-config.php ]; then
    echo "Creating wp-config.php..."
    cd /var/www/wordpress
    wp config create --allow-root \
        --dbname=$SQL_DATABASE \
        --dbuser=$SQL_USER \
        --dbpass=$SQL_PASSWORD \
        --dbhost=mariadb 
        # --path='/var/www/wordpress'
fi

# Si WordPress n'est pas encore installé, l'installer
if ! wp core is-installed --allow-root --path='/var/www/wordpress'; then
    wp core install --allow-root \
        --url="http://localhost" \
        --title="My WordPress Site" \
        --admin_user=$WP_ADMIN \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL \
        --path='/var/www/wordpress'

    # Ajouter un deuxième utilisateur comme demandé par le sujet
    wp user create $WP_USER_NAME $WP_USER_NAME@example.com --role=author --user_pass=$WP_USER_PASSWORD --allow-root --path='/var/www/wordpress'
fi

# S'assurer que le dossier PHP existe
mkdir -p /run/php

# Lancer PHP-FPM
exec /usr/sbin/php-fpm7.4 -F