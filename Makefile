all: help

start:
	@build/start.sh

clean:
	@build/clean.sh

help:
	@echo "Welcome to Grizzly WordPress!"
	@echo "  make start"
	@echo "    - Creates a .env file ready for you to enter your credentials"
	@echo "  make clean"
	@echo "    - Garbage collection for docker"

.PHONY: start clean
