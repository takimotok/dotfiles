#!/bin/bash

#
# set global variables which are used in other `*.sh`
#

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_PATH="$HOME/projects/github.com/takimotok/dotfiles"
if [ "$(PROJECT_ROOT)" != "$DOTFILES_PATH" ]; then
  # enable ghq to access
  # `ghq root` is defined in `.gitconfig`
  PROJECT_ROOT="$DOTFILES_PATH"
fi
