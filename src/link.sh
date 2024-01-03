#!/bin/bash

set -Ceu

(
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
