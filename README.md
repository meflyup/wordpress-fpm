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
* Manage plugins with composer / wp-cli
* Create a Makefile for tasks (cleanup, etc.)
* Make sure nothing belongs to root that shouldn't
* Perform uploads test as shown here: https://codex.wordpress.org/Nginx
* Deployment and CI (git push triggers post-recieve hook using travis paired with gulp deploy-dev)
* Create CI tests (Healthcheck)
* Utilize docker machine for deploys
* Include grizzly theme
* Find solution for database and uplods folder
* Optimize PHP (Varnish, Redis, Memcached)
* Considerations for multiple environments
