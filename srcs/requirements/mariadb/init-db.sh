#!/bin/bash

if [ ! -d "/var/lib/mysql/wordpress" ]; then
    service mariadb start
    
    mysql -e "CREATE DATABASE wordpress;"
    mysql -e "CREATE USER 'wp_user'@'%' IDENTIFIED BY 'wp_pass';"
    mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wp_user'@'%';"
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
    mysql -e "FLUSH PRIVILEGES;"
    
    service mariadb stop
fi

exec mysqld_safe