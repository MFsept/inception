#!/bin/bash
set -e

mysqld_safe --skip-networking --skip-grant-tables &

until mysqladmin --protocol=socket ping --silent; do
    sleep 1
done

mysql --protocol=socket -u root <<SQL
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
ALTER USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
SQL

mysqladmin --protocol=socket -uroot -p"${MYSQL_ROOT_PASSWORD}" shutdown || true

exec mysqld_safe