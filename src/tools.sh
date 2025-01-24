#!/bin/bash

set -Ceu

(
  main() {
    _g_cd "$PROJECT_ROOT"

    # install some languages by mise
    . ./packages/mise/install.sh
  }

  main
)
