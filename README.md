# WordPress FPM
A modern WordPress LEMP stack for Docker

* WordPress - 4.6
* MariaDB - 10.1.17
* PHP-FPM - 7.0.10
* NGINX - 1.10.1

## Local Dependencies
* [Docker 1.12.0](https://www.docker.com/products/docker)
* PHP 7.0.8 - `brew install php70`
* Composer 1.1.2 - `brew install composer`

## Getting Started
* Run `make env` and enter your credentials in the `.env` file
* Run `composer install` to install WordPress plugin dependencies
* Run `make start` to download the images and start the containers (runs `docker-compose up -d`)
* Web server runs on `localhost:8080`
* Database runs on `localhost:8081`
* Run `make stop` to stop the containers (runs `docker-compose stop`)
* Run `make clean` for garbage collection (use with caution, will remove unused images, containers, and volumes)

## Plugins
* Plugins should only be installed with composer via [wpackagist](https://wpackagist.org/)
* Premium plugins should be included as [required plugins](http://tgmpluginactivation.com/)

## Issue Tracking
* If you get a database error on startup, it may be that mysql hasn't fully started yet. Try again in a few seconds. You can run `docker-compose up` (without the -d flag) to tail the logs at runtime.
* Please create a GitHub issue for bugs and feature requests and be as detailed as possible. Or better yet, send a pull request.

## TODO
* Make sure nothing belongs to root that shouldn't
* Perform uploads test as shown here: https://codex.wordpress.org/Nginx
* Optimize PHP (Varnish, Redis, Memcached)
* Considerations for multiple environments
* Find solution for database and uplods folder

## Grizzly Version
* Cone the repo - `git clone git@github.com:joshcummingsdesign/wordpress-fpm.git ./`
* Re-initialize Git - `rm -rf .git && git init && git add . && git commit -m "Initial commit"`
* Cut ties to the repo and push to the new one - `git remote add origin [repo-url] && git push -u origin master`
* Include grizzly theme
* Proxy port 8080 for browsersync
* Utilize docker machine for deploys
* Deployment and CI (git push triggers post-recieve hook using travis paired with gulp deploy-dev)
* Create CI tests (Healthcheck)
