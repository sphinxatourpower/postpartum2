<?php
define('TIMEZONE', 'Asia/Taipei');
define('SERVER_ADDR', 'localhost');
// HTTP
define('HTTP_SERVER', 'http://'.SERVER_ADDR.'/postpartum2/');
define('HTTP_IMAGE', 'http://'.SERVER_ADDR.'/postpartum2/data-img/');

// HTTPS
define('HTTPS_SERVER', 'http://'.SERVER_ADDR.'/postpartum2/');
define('HTTPS_IMAGE', 'http://'.SERVER_ADDR.'/postpartum2/data-img/');

// DIR
define('DOCROOT', '/Library/WebServer/Documents');
define('DIR_APPLICATION', DOCROOT.'/postpartum2/');
define('DIR_SYSTEM', DOCROOT.'/postpartum2/system/');
define('DIR_DATABASE', DOCROOT.'/postpartum2/system/database/');
define('DIR_LANGUAGE', DOCROOT.'/postpartum2/language/');
define('DIR_TEMPLATE', DOCROOT.'/postpartum2/view/template/');
define('DIR_CONFIG', DOCROOT.'/postpartum2/system/config/');
define('DIR_IMAGE', DOCROOT.'/postpartum2/data-img/');
define('DIR_CACHE', DOCROOT.'/postpartum2/system/cache/');
define('DIR_DOWNLOAD', DOCROOT.'/postpartum2/data-export/');
define('DIR_LOGS', DOCROOT.'/postpartum2/system/logs/');
define('DIR_SESSIONS', DOCROOT . '/postpartum2/system/sessions/');
define('OURPOWER_SUPPORT', 'OURPOWER');
define('OURPOWER_SUPPORT_URL', 'http://www.ourpower.com.tw');
define('PCOMPANY', '晨昕產後護理之家');
define('PCOMPANY_SHORT', '晨昕');

// DB
define('DB_DRIVER', 'oc_pdo');
define('DB_HOSTNAME', 'localhost');
define('DB_USERNAME', 'postpartum');
define('DB_PASSWORD', '12345678');
define('DB_DATABASE', 'postpartum');
define('DB_PREFIX', '');
?>