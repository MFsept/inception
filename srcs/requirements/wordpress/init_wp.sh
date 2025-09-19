#!/bin/bash


mkdir -p /var/log
touch /var/log/fpm-php.www.log
chown www-data:www-data /var/log/fpm-php.www.log

while ! mysqladmin ping -h"$MYSQL_HOST" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" --silent; do
    sleep 2
done

rm -f /var/www/wordpress/wp-config.php /var/www/wordpress/wp-config-sample.php

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

define('WP_SITEURL', 'https://$MY_DOMAIN_NAME');
define('WP_HOME', 'https://$MY_DOMAIN_NAME');

if ( !defined('ABSPATH') )
    define('ABSPATH', dirname(__FILE__) . '/');

require_once(ABSPATH . 'wp-settings.php');
EOF


chown -R www-data:www-data /var/www/wordpress
chmod -R 755 /var/www/wordpress

WP_INSTALLED=$(mysql -h"$MYSQL_HOST" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE" -e "SHOW TABLES LIKE 'wp_users';" 2>/dev/null | wc -l)

if [ "$WP_INSTALLED" -eq 0 ]; then
    
    cat > /tmp/wp_install.php << 'PHPEOF'
<?php
define('WP_INSTALLING', true);
require_once('/var/www/wordpress/wp-config.php');
require_once('/var/www/wordpress/wp-admin/includes/upgrade.php');

wp_install('Mon Site WordPress', 'boss', 'admin@localhost', true, '', 'bosspassword');

wp_create_user('user', 'userpassword', 'user@localhost');

wp_insert_post(array(
    'post_title' => 'Bienvenue sur mon site',
    'post_content' => '<h2>Bienvenue !</h2><p>Voici mon site WordPress preconfigure avec Docker 🐳​.</p>',
    'post_status' => 'publish',
    'post_type' => 'page'
));

?>
PHPEOF

    php /tmp/wp_install.php
    rm -f /tmp/wp_install.php
    
else
    echo "WordPress Already install."
fi

exec php-fpm8.2 -F