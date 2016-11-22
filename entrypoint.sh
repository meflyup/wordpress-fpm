#!/bin/bash

set -e

# chown wp-content folder
chown -R www-data:www-data /var/www/html/wp-content

# set hostname
SERVER_NAME=$(echo $SITE_HOST | sed "s/:.*$//")
sed -i -e "s/localhost/$SERVER_NAME/g" /etc/nginx/sites-available/default
sed -i -e "s/example.com/$SITE_HOST/g" /etc/nginx/sites-available/default
sed -i -e "s/example.com/$SITE_HOST/g" /etc/nginx/global/wordpress.conf

# build ssmtp.conf
echo "root=$SMTP_EMAIL" >> /etc/ssmtp/ssmtp.conf
echo "mailhub=smtp.gmail.com:465" >> /etc/ssmtp/ssmtp.conf
echo "rewriteDomain=gmail.com" >> /etc/ssmtp/ssmtp.conf
echo "AuthUser=$SMTP_EMAIL" >> /etc/ssmtp/ssmtp.conf
echo "AuthPass=$SMTP_PASSWORD" >> /etc/ssmtp/ssmtp.conf
echo "FromLineOverride=YES" >> /etc/ssmtp/ssmtp.conf
echo "UseTLS=YES" >> /etc/ssmtp/ssmtp.conf

# set the database environment variables
: "${WORDPRESS_DB_HOST:=$DB_HOST}"
: "${WORDPRESS_DB_USER:=$DB_USER}"
: "${WORDPRESS_DB_PASSWORD:=$DB_PASSWORD}"
: "${WORDPRESS_DB_NAME:=$DB_NAME}"

# create the database if it does not exist
TERM=dumb php -- "$WORDPRESS_DB_HOST" "$WORDPRESS_DB_USER" "$WORDPRESS_DB_PASSWORD" "$WORDPRESS_DB_NAME" <<'EOPHP'
<?php

  // database might not exist, so let's try creating it (just to be safe)
  $stderr = fopen('php://stderr', 'w');

  // https://codex.wordpress.org/Editing_wp-config.php#MySQL_Alternate_Port
  //   "hostname:port"
  // https://codex.wordpress.org/Editing_wp-config.php#MySQL_Sockets_or_Pipes
  //   "hostname:unix-socket-path"
  list($host, $socket) = explode(':', $argv[1], 2);
  $port = 0;

  if (is_numeric($socket)) {
    $port = (int) $socket;
    $socket = null;
  }

  $maxTries = 10;
  do {
    $mysql = new mysqli($host, $argv[2], $argv[3], '', $port, $socket);

    if ($mysql->connect_error) {
      fwrite($stderr, "\n" . 'MySQL Connection Error: (' . $mysql->connect_errno . ') ' . $mysql->connect_error . "\n");
      --$maxTries;
      if ($maxTries <= 0) {
        exit(1);
      }
      sleep(3);
    }
  } while ($mysql->connect_error);

  if (!$mysql->query('CREATE DATABASE IF NOT EXISTS `' . $mysql->real_escape_string($argv[4]) . '`')) {
    fwrite($stderr, "\n" . 'MySQL "CREATE DATABASE" Error: ' . $mysql->error . "\n");
    $mysql->close();
    exit(1);
  }

  $mysql->close();
EOPHP

exec "$@"
