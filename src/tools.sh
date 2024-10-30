#!/bin/bash

set -Ceu

(
  main() {
    _g_cd "$PROJECT_ROOT"

    # copy aliases
    if [ ! -f "$PROJECT_ROOT/.config/zsh/rc/aliases.zsh" ]; then
      copy_from="$PROJECT_ROOT/packages/zsh/aliases.zsh.example"
      copy_to="$PROJECT_ROOT/.config/zsh/rc/alias.zsh"
      cp "$copy_from" "$copy_to"
    fi

    # install some languages by mise
    . ./packages/mise/install.sh
  }

  main
)
