#!/bin/bash
set -e

# Always ensure DB user and password are correct, even if DB exists
echo "[init-db] Bootstrapping MariaDB with grants disabled..."
mysqld_safe --skip-networking --skip-grant-tables &

# Wait for MariaDB to be ready (socket)
until mysqladmin --protocol=socket ping --silent; do
    sleep 1
done

# Set root password and create application DB/user
mysql --protocol=socket -u root <<SQL
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
ALTER USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
SQL

echo "[init-db] Shutting down bootstrap server..."
mysqladmin --protocol=socket -uroot -p"${MYSQL_ROOT_PASSWORD}" shutdown || true

echo "[init-db] Starting MariaDB normally..."
exec mysqld_safe