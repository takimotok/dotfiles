#!/bin/bash

set -Ceu

(
  main() {
    _g_cd "$PROJECT_ROOT"

    # install some languages
    mise install -y

    # setup rust
    rustup-init
  }

  main
)
