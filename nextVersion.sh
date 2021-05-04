#!/bin/bash

RE='[^0-9]*\([0-9]*\)[.]\([0-9]*\)[.]\([0-9]*\)\([0-9A-Za-z-]*\)'

step="$1"
if [ -z "$1" ]; then
  step="minor"
fi

base="$2"
if [ -z "$2" ]; then
  base=$(git tag --sort=taggerdate  | tail -n 1)
  if [ -z "$base" ]; then
    base=0.0.0
  fi
fi

# shellcheck disable=SC2001
MAJOR=$(echo $base | sed -e "s#$RE#\1#")
# shellcheck disable=SC2001
MINOR=$(echo $base | sed -e "s#$RE#\2#")
# shellcheck disable=SC2001
PATCH=$(echo $base | sed -e "s#$RE#\3#")

case "$step" in
major) ((MAJOR += 1)) ;;
minor) ((MINOR += 1)) ;;
patch) ((PATCH += 1)) ;;
esac

echo "$MAJOR.$MINOR.$PATCH"
