#!/bin/bash

set -Ceu

(
  main() {
    . ./src/libs/variables.sh
    . ./src/libs/functions.sh

    _print_start_message

    # initial setup
    . ./src/init.sh

    # link dotfiles to both $HOME and $XDG_CONFIG_HOME
    . ./src/link.sh

    # setup mac
    . ./src/defaults.sh

    # setup some tools
    . ./src/tools.sh

    _print_finish_message
  }

  main
)

exit 0
