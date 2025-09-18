<?php

define('DB_NAME', getenv('MYSQL_DATABASE') ? getenv('MYSQL_DATABASE') : 'wordpress');
define('DB_USER', getenv('MYSQL_USER') ? getenv('MYSQL_USER') : 'wp_user');
define('DB_PASSWORD', getenv('MYSQL_PASSWORD') ? getenv('MYSQL_PASSWORD') : 'usermdpinception');
define('DB_HOST', getenv('MYSQL_HOST') ? getenv('MYSQL_HOST') : 'mariadb');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');


define('AUTH_KEY',         'F(8|{o>ivE+4KcV#lZ7:2m%H)g)+rl.#;EKS}F&Fk/OW5mbt9;F^#.ox}#FU6g,`');
define('SECURE_AUTH_KEY',  'KyBdXrg]dSVIF=,*NOC&|l$s(F}T*NW&eI1A>D}$=p^bSbol|F2-mG?/JmVn)d$,');
define('LOGGED_IN_KEY',    'q^-7X!B:B=w_1/[X78fMxFumqgAJ0@61wRXCzaVv:bj33F^cj%D>5e!tVdrF[K~z');
define('NONCE_KEY',        ')+TG+:AM2.;}!{]UE4N+2HrjOGqaFqRtl[)!M+Xux,D8:iaa^+F{>tM-9?i @v3:');
define('AUTH_SALT',        '&?alPDQ&Muc@V~8}t=2d--4,Cy)fv_.rG%-dMS{DptP9)GU,-HY2F6^4f)_MlWqM');
define('SECURE_AUTH_SALT', '6U@)T;Oy6g#S-+O<T>a1_&14~WeCZFTG1*yD<}f msYJyu&!,9j7wSH.!|r GSI%');
define('LOGGED_IN_SALT',   'Ku=0`$P r!|uV^&c@|!mj8*i+`=e,7?5W*[.hij}jk`Qed?_2(mO4Ck^(gawaSY5');
define('NONCE_SALT',       'MCJ,VdE+G#s;s&[p9Qzn-x^ {g?(S-^03x73K3 l#DN-pi6_;A><iw37zS-XNTd#');


$table_prefix = 'wp_';

define('WP_DEBUG', false);


if ( !defined('ABSPATH') )
    define('ABSPATH', dirname(__FILE__) . '/');

// Load WordPress
require_once(ABSPATH . 'wp-settings.php');

