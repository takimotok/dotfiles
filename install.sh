#!/bin/bash

set -Ceu

(
  main() {
    . ./src/app/start_message.sh

    # set global variables which are used in other `*.sh`
    PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    # initial setup
    . ./src/libs/init.sh

    # link dotfiles to both $HOME and $XDG_CONFIG_HOME
    . ./src/libs/link.sh

    # setup ssh for github
    . ./src/libs/defaults.sh

    # setup mac
    . ./src/libs/defaults.sh

    . ./src/app/finish_message.sh
  }

  main
)

exit 0
