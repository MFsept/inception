#!/bin/bash
set -e
cd /var/www/wordpress

# Wait for DB
until wp db check --allow-root; do
  sleep 1
done

if ! wp core is-installed --allow-root; then
  wp core install --url="https://localhost:4443" --title="Inception42" --admin_user="admin" --admin_password="admin42" --admin_email="admin@localhost" --skip-email --allow-root
  wp option update blogdescription "Projet Inception 42" --allow-root
  wp theme activate twentytwentytwo --allow-root
fi

chown -R www-data:www-data /var/www/wordpress
