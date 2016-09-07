#!/bin/sh

ESC_SEQ="\x1b["
COL_RED=$ESC_SEQ"31;01m"
COL_GREEN=$ESC_SEQ"32;01m"
COL_RESET=$ESC_SEQ"39;49;00m"

pretty_print() {
  printf "%b\n" "$1"
}

ENV_FILE=.env

if [ ! -f $ENV_FILE ];
  then
    pretty_print "$COL_RED No .env file detected. Please run 'make env' first. $COL_RESET"
  else
    docker-compose stop
fi
