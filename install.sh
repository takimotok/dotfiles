#!/bin/bash

set -Ceu

(
  main() {
    . ./src/libs/functions.sh

    _print_start_message

    # set global variables which are used in other `*.sh`
    PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    # initial setup
    . ./src/init.sh

    # link dotfiles to both $HOME and $XDG_CONFIG_HOME
    . ./src/link.sh

    # setup mac
    . ./src/defaults.sh

    _print_finish_message
  }

  main
)

exit 0
