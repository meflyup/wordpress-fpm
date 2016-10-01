# WordPress FPM

[![semantic versioning](https://img.shields.io/github/release/joshcummingsdesign/wordpress-fpm.svg)](https://github.com/joshcummingsdesign/wordpress-fpm)

A modern WordPress LEMP stack for Docker

* WordPress
* PHP-FPM 7
* NGINX

## Tags

The first part of the tag is the version of WordPress and the second part is the version of PHP-FPM.

* jgriz/wpfpm:4.6.1-7.0.11 [(Dockerfile)](https://github.com/joshcummingsdesign/wordpress-fpm/blob/4.6.1-7.0.11/Dockerfile)

## Example docker-compose.yml

```shell
version: '2'
services:
  wordpress:
    image: jgriz/wordpress-fpm
    env_file: ./.env
    ports:
      - 8080:80
    volumes:
      - ./wp-content:/var/www/html/wp-content
    links:
      - mysql
  mysql:
    image: mariadb:10.1.17
    ports:
      - 8081:3306
    environment:
      MYSQL_ROOT_PASSWORD: ${DB_PASSWORD}
      MYSQL_USER: ${DB_USER}
      MYSQL_PASSWORD: ${DB_PASSWORD}
      MYSQL_DATABASE: ${DB_NAME}
```

## Example .env

```shell
# wp-config
DB_NAME=[ENTER DB NAME]
DB_USER=[ENTER DB USER]
DB_PASSWORD=[ENTER DB PASSWORD]
DB_HOST=mysql
TABLE_PREFIX=wp_
WP_DEBUG=true

# smtp
SMTP_EMAIL=[ENTER EMAIL ADDRESS]
SMTP_PASSWORD=[ENTER EMAIL PASSWORD]

# salts - https://api.wordpress.org/secret-key/1.1/salt/
AUTH_KEY=[PASTE-UNIQUE-VALUE]
SECURE_AUTH_KEY=[PASTE-UNIQUE-VALUE]
LOGGED_IN_KEY=[PASTE-UNIQUE-VALUE]
NONCE_KEY=[PASTE-UNIQUE-VALUE]
AUTH_SALT=[PASTE-UNIQUE-VALUE]
SECURE_AUTH_SALT=[PASTE-UNIQUE-VALUE]
LOGGED_IN_SALT=[PASTE-UNIQUE-VALUE]
NONCE_SALT=[PASTE-UNIQUE-VALUE]
```
