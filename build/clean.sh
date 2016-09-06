#!/bin/sh

ESC_SEQ="\x1b["
COL_RED=$ESC_SEQ"31;01m"
COL_RESET=$ESC_SEQ"39;49;00m"

pretty_print() {
  printf "%b\n" "$1"
}

EXITED=$(docker ps -aq -f status=exited)
DANGLING=$(docker images -q -f "dangling=true")
VOLUMES=$(docker volume ls -qf "dangling=true")

if [ -n "$EXITED" ]; then
  echo "Removing these containers:"
  docker rm $EXITED
else
  pretty_print "$COL_RED No containers to remove. $COL_RESET"
fi
if [ -n "$DANGLING" ]; then
  echo "Removing these images:"
  docker rmi $DANGLING
else
  pretty_print "$COL_RED No images to remove. $COL_RESET"
fi
if [ -n "$VOLUMES" ]; then
  echo "Removing these volumes:"
  docker volume rm $VOLUMES
else
  pretty_print "$COL_RED No volumes to remove. $COL_RESET"
fi
