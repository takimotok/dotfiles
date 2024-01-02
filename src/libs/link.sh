#!/bin/bash

set -Ceu

(
  . ./src/libs/functions.sh

  main() {
    _g_cd "$PROJECT_ROOT"

    stow \
      -R \
      -d . \
      -t ~/.config \
      .config
  }

  main
)
