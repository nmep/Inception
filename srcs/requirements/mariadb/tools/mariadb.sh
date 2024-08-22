#!/bin/bash

service mariadb start;

(mysql -u root -p${SQL_ROOT_PASSWORD} -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;" && echo "create dabase success") || echo "create db failed"

(mysql -u root -p${SQL_ROOT_PASSWORD} -e "CREATE USER IF NOT EXISTS ${SQL_USER}@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';" && echo "create user success") || echo "create user failed"

(mysql -u root -p${SQL_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';" &&  echo sql user got all privilege sucess) || echo sql user grant privilege failed

# Set root password
(mysql -u root -p${SQL_ROOT_PASSWORD} -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';" && echo "alter user success") || echo "sql root user password changed failed"; 

# Flush privileges

mysql -u root -p$SQL_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"

# (mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';" && echo "alter user success") || echo sql root user pssword changed failed

if mysqladmin -u root -p$SQL_ROOT_PASSWORD ping > /dev/null 2>&1; then
    (mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown && echo shutdown success) || echo shutdown failed
fi

exec mysqld_safe
