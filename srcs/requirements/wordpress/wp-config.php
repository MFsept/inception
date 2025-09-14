<?php
// Pull DB settings from environment with fallbacks for local dev
$db_host = getenv('MYSQL_HOST') ?: 'mariadb:3306';
$db_name = getenv('MYSQL_DATABASE') ?: 'wordpress';
$db_user = getenv('MYSQL_USER') ?: 'wp_user';
$db_pass = getenv('MYSQL_PASSWORD') ?: 'wp_pass';

define('DB_HOST', $db_host);
define('DB_USER', $db_user);
define('DB_PASSWORD', $db_pass);
define('DB_NAME', $db_name);

// You can add salts/keys here or via environment as well
// ... rest of WordPress config as needed ...
?>

