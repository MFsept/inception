#!/bin/bash
set -e

# Attendre que MariaDB soit prêt
echo "Attente de MariaDB..."
while ! mysqladmin ping -h"$MYSQL_HOST" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" --silent; do
    sleep 1
done
echo "MariaDB est prêt !"

# Démarrer PHP-FPM
echo "Démarrage de PHP-FPM..."
exec php-fpm8.2 -F