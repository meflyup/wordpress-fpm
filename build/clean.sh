#!/bin/sh

ESC_SEQ="\x1b["
COL_RED=$ESC_SEQ"31;01m"
COL_GREEN=$ESC_SEQ"32;01m"
COL_RESET=$ESC_SEQ"39;49;00m"

pretty_print() {
  printf "%b\n" "$1"
}

EXITED=$(docker ps -aqf status=exited)
DANGLING=$(docker images -qf "dangling=true")
VOLUMES=$(docker volume ls -qf "dangling=true")

if [ -n "$EXITED" ]; then
  pretty_print "$COL_RED Removing these containers: $COL_RESET"
  docker rm $EXITED
else
  pretty_print "$COL_GREEN No containers to remove. $COL_RESET"
fi
if [ -n "$DANGLING" ]; then
  pretty_print "$COL_RED Removing these images: $COL_RESET"
  docker rmi $DANGLING
else
  pretty_print "$COL_GREEN No images to remove. $COL_RESET"
fi
if [ -n "$VOLUMES" ]; then
  pretty_print "$COL_RED Removing these volumes: $COL_RESET"
  docker volume rm $VOLUMES
else
  pretty_print "$COL_GREEN No volumes to remove. $COL_RESET"
fi
