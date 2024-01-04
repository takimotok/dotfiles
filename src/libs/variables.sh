#!/bin/bash

#
# set global variables which are used in other `*.sh`
#

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ "$(PROJECT_ROOT)" != "$HOME/projects/github.com/takimotok" ]; then
  # enable ghq to access
  # `ghq root` is defined in `.gitconfig`
  PROJECT_ROOT="$HOME/projects/github.com/takimotok"
fi
