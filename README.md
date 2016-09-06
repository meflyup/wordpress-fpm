# WordPress FPM
A modern WordPress LEMP stack for Docker

* WordPress - 4.6
* MariaDB - 10.1.17
* PHP-FPM - 7.0.10
* NGINX - 1.10.1

## Requirements
* [Docker 1.12.0 or later](https://www.docker.com/products/docker)

## Getting Started
* Create a `.env` file
* Run `docker-compose up -d`

## TODO
* Use environment variables for database creds
* Automate creation of .env and salts
* Add wp-cli
* Add plugins with wp-cli or composer
* Perform uploads test as shown here: https://codex.wordpress.org/Nginx
* Include grizzly theme
* Create a Makefile for tasks (cleanup, etc.)
* Documentation
* Deployment and CI (git push triggers post-recieve hook using travis paired with gulp deploy-dev)
* Find solution for database and uplods folder
* Optimize PHP (Varnish, Redis, Memcached)
* Create CI tests
