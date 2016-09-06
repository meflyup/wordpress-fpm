all: help

env:
	@build/env.sh

start:
	@docker-compose up -d

stop:
	@docker-compose stop

clean:
	@build/clean.sh

help:
	@echo "Welcome to Grizzly WordPress!"
	@echo "  make env"
	@echo "    - Creates a .env file ready for you to enter your credentials"
	@echo "  make start"
	@echo "    - Downloads images and starts containers"
	@echo "  make stop"
	@echo "    - Stops containers"
	@echo "  make clean"
	@echo "    - Garbage collection for docker"

.PHONY: env start stop clean
