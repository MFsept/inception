<?php

define('DB_NAME', getenv('MYSQL_DATABASE') ? getenv('MYSQL_DATABASE') : 'wordpress');
define('DB_USER', getenv('MYSQL_USER') ? getenv('MYSQL_USER') : 'wp_user');
define('DB_PASSWORD', getenv('MYSQL_PASSWORD') ? getenv('MYSQL_PASSWORD') : 'usermdpinception');
define('DB_HOST', getenv('MYSQL_HOST') ? getenv('MYSQL_HOST') : 'mariadb');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');


define('AUTH_KEY',         'put-your-unique-phrase-here');
define('SECURE_AUTH_KEY',  'put-your-unique-phrase-here');
define('LOGGED_IN_KEY',    'put-your-unique-phrase-here');
define('NONCE_KEY',        'put-your-unique-phrase-here');
define('AUTH_SALT',        'put-your-unique-phrase-here');
define('SECURE_AUTH_SALT', 'put-your-unique-phrase-here');
define('LOGGED_IN_SALT',   'put-your-unique-phrase-here');
define('NONCE_SALT',       'put-your-unique-phrase-here');


$table_prefix = 'wp_';

define('WP_DEBUG', false);


if ( !defined('ABSPATH') )
    define('ABSPATH', dirname(__FILE__) . '/');

// Load WordPress
require_once(ABSPATH . 'wp-settings.php');

