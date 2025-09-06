#!/bin/bash

if [ ! -d "/var/lib/mysql/wordpress" ]; then
    service mariadb start
    
    mysql -e "CREATE DATABASE ${MYSQL_DATABASE};"
    mysql -e "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
    mysql -e "FLUSH PRIVILEGES;"
    
    service mariadb stop
fi

exec mysqld_safe