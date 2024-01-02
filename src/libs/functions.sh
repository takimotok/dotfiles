#!/bin/bash

_g_cd() {
  cd "$@" || {
    echo "Error! Couldn't move to $* !"
    exit 1
  }
}

_exit_with_errors() {
  [ "$1" = 0 ] && return

  printf "Exit %s" "$@"
  exit "$@"
}

_is_macos() {
  if [ "$(uname)" != "Darwin" ]; then
    echo "Not macOS!"
    exit 1
  fi
}

