#!/bin/bash

echo "=== Démarrage WordPress avec installation automatique ==="

# Créer les répertoires nécessaires
mkdir -p /var/log
touch /var/log/fpm-php.www.log
chown www-data:www-data /var/log/fpm-php.www.log

# Attendre MariaDB
echo "Attente de MariaDB..."
while ! mysqladmin ping -h"$MYSQL_HOST" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" --silent; do
    echo "En attente de MariaDB..."
    sleep 2
done
echo "MariaDB prêt !"

# Supprimer tout wp-config existant pour éviter les conflits
rm -f /var/www/wordpress/wp-config.php /var/www/wordpress/wp-config-sample.php

# Créer un wp-config.php complet avec toutes les constantes WordPress
cat > /var/www/wordpress/wp-config.php << EOF
<?php
define('DB_NAME', '$MYSQL_DATABASE');
define('DB_USER', '$MYSQL_USER');
define('DB_PASSWORD', '$MYSQL_PASSWORD');
define('DB_HOST', '$MYSQL_HOST');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');

define('AUTH_KEY',         'auth-key-secure-$(date +%s)');
define('SECURE_AUTH_KEY',  'secure-auth-key-$(date +%s)');
define('LOGGED_IN_KEY',    'logged-in-key-$(date +%s)');
define('NONCE_KEY',        'nonce-key-$(date +%s)');
define('AUTH_SALT',        'auth-salt-$(date +%s)');
define('SECURE_AUTH_SALT', 'secure-auth-salt-$(date +%s)');
define('LOGGED_IN_SALT',   'logged-in-salt-$(date +%s)');
define('NONCE_SALT',       'nonce-salt-$(date +%s)');

\$table_prefix = 'wp_';
define('WP_DEBUG', false);

// Éviter les redirections automatiques vers wp-admin/install.php
define('WP_SITEURL', 'https://$MY_DOMAIN_NAME:4443');
define('WP_HOME', 'https://$MY_DOMAIN_NAME:4443');

if ( !defined('ABSPATH') )
    define('ABSPATH', dirname(__FILE__) . '/');

require_once(ABSPATH . 'wp-settings.php');
EOF

# Permissions
chown -R www-data:www-data /var/www/wordpress
chmod -R 755 /var/www/wordpress

# Vérifier si WordPress est déjà installé en vérifiant les tables
WP_INSTALLED=$(mysql -h"$MYSQL_HOST" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE" -e "SHOW TABLES LIKE 'wp_users';" 2>/dev/null | wc -l)

if [ "$WP_INSTALLED" -eq 0 ]; then
    echo "Installation automatique de WordPress..."
    
    # Script PHP pour installer WordPress automatiquement
    cat > /tmp/wp_install.php << 'PHPEOF'
<?php
define('WP_INSTALLING', true);
require_once('/var/www/wordpress/wp-config.php');
require_once('/var/www/wordpress/wp-admin/includes/upgrade.php');

// Installer WordPress
wp_install('Mon Site WordPress', 'admin', 'admin@localhost', true, '', 'admin123');

// Créer quelques pages de contenu par défaut
wp_insert_post(array(
    'post_title' => 'Bienvenue sur mon site',
    'post_content' => '<h2>Bienvenue !</h2><p>Voici mon site WordPress configuré automatiquement avec Docker.</p>',
    'post_status' => 'publish',
    'post_type' => 'page'
));

echo "WordPress installé avec succès !";
?>
PHPEOF

    # Exécuter l'installation
    php /tmp/wp_install.php
    rm -f /tmp/wp_install.php
    
    echo "WordPress configuré automatiquement !"
else
    echo "WordPress déjà installé, pas de réinstallation."
fi

echo "Démarrage PHP-FPM..."
exec php-fpm8.2 -F