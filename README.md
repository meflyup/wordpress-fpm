# WordPress FPM
A modern WordPress LEMP stack for Docker

* WordPress - 4.6
* MariaDB - 10.1.17
* PHP-FPM - 7.0.10
* NGINX - 1.10.1

## Dependencies
* [Docker 1.12.0](https://www.docker.com/products/docker)
* PHP 7.0.8 - `brew install php70`
* Composer 1.1.2 - `brew install composer`

## Getting Started
* Run `make start` and enter your credentials in the `.env` file
* Run `composer install` to install WordPress plugin dependencies
* Run `docker-compose up -d`
* Web server runs on `localhost:8080`
* Database runs on `localhost:8081`
* Run `make clean` for garbage collection

## Plugins
* Plugins should only be installed with composer via wpackagist
* Premium plugins should be installed as required plugins

## Issue Tracking
* If you get a database error on startup, it may mean mysql hasn't fully started. Try again in a few seconds. You can run docker-compose without the -d flag to tail the logs at runtime.
* Please create a GitHub issue for bugs and feature requests and be as detailed as possible.

## TODO
* Make sure nothing belongs to root that shouldn't
* Perform uploads test as shown here: https://codex.wordpress.org/Nginx
* Include grizzly theme
* Proxy port 8080 for browsersync
* Utilize docker machine for deploys
* Deployment and CI (git push triggers post-recieve hook using travis paired with gulp deploy-dev)
* Create CI tests (Healthcheck)
* Optimize PHP (Varnish, Redis, Memcached)
* Considerations for multiple environments
* Find solution for database and uplods folder
