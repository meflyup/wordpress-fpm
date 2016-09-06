# WordPress FPM
A modern WordPress LEMP stack for Docker

* WordPress - 4.6
* MariaDB - 10.1.17
* PHP-FPM - 7.0.10
* NGINX - 1.10.1

## Requirements
* [Docker 1.12.0 or later](https://www.docker.com/products/docker)
* Start script `./start.sh` requires PHP to be installed locally

## Getting Started
* Run `./start.sh` and fill out your credentials in the `.env` file
* Run `docker-compose up -d`
* Web server runs on `localhost:8080`
* Database runs on `localhost:8081`

## TODO
* Add wp-cli
* Track plugins with composer
* Perform uploads test as shown here: https://codex.wordpress.org/Nginx
* Create a Makefile for tasks (cleanup, etc.)
* Deployment and CI (git push triggers post-recieve hook using travis paired with gulp deploy-dev)
* Include grizzly theme
* Find solution for database and uplods folder
* Optimize PHP (Varnish, Redis, Memcached)
* Create CI tests
* Considerations for multiple environments
