#!/bin/bash

service mariadb start;

sleep 5

(mysql -u root -p${SQL_ROOT_PASSWORD} -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;" && echo "create dabase success") || echo "create db failed"

(mysql -u root -p${SQL_ROOT_PASSWORD} -e "CREATE USER IF NOT EXISTS ${SQL_USER}@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';" && echo "create user success") || echo "create user failed"

(mysql -u root -p${SQL_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';" &&  echo sql user got all privilege sucess) || echo sql user grant privilege failed

# Set root password
(mysql -u root -p$SQL_ROOT_PASSWORD -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';" && echo "alter user success") || echo sql root user pssword changed failed

# Flush privileges

mysql -u root -p$SQL_ROOT_PASSWORD -e "FLUSH PRIVILEGES;" || echo flush failed


# if [ -f /run/mysqld/mysqld.sock ]; then 
(mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown && echo shut down success) || echo shutdown failed

# fi

exec mysqld_safe

# if pgrep mysqld > /dev/null
# then
#     echo "Stopping existing MariaDB process"
#     service mariadb stop
#     sleep 5
# fi

# echo "Starting MariaDB service"
# service mariadb start

# # Ajouter un délai pour s'assurer que MariaDB est complètement démarré
# sleep 5

# # Vérifier si MariaDB est en cours d'exécution avant de continuer
# if ! pgrep mysqld > /dev/null
# then
#     echo "MariaDB did not start successfully"
#     exit 1
# fi

# # Créer la base de données si elle n'existe pas
# mysql -u root -p"$SQL_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"

# # Créer l'utilisateur SQL s'il n'existe pas, avec accès global
# mysql -u root -p"$SQL_ROOT_PASSWORD" -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
# mysql -u root -p"$SQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';"

# # Configurer l'utilisateur root pour des connexions distantes
# mysql -u root -p"$SQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$SQL_ROOT_PASSWORD' WITH GRANT OPTION;"

# # Rafraîchir les privilèges pour que les modifications prennent effet
# mysql -u root -p"$SQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"

# # Arrêter proprement MariaDB avec mysqladmin shutdown
# echo "Shutting down MariaDB with mysqladmin"
# mysqladmin -u root -p"$SQL_ROOT_PASSWORD"j shutdown

# # Attendre quelques secondes pour que MariaDB soit complètement arrêté
# sleep 5

# # Redémarrer MariaDB avec le service
# echo "Restarting MariaDB service"
# exec mysqld_safe

# echo "MariaDB setup complete"