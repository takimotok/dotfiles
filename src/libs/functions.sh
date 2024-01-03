#!/bin/bash

_g_cd() {
  cd "$@" || {
    echo "Error! Couldn't move to $* !"
    exit 1
  }
}

_exit_with_errors() {
  [ "$1" = 0 ] && return

  printf "Exit %s" "$@"
  exit "$@"
}

_is_macos() {
  if [ "$(uname)" != "Darwin" ]; then
    echo "Not macOS!"
    exit 1
  fi
}

_print_start_message() {
  printf "start %s...\\n" "${0}"
  printf "\\n"
}

_print_finish_message() {
  printf "🎉 All tasks done !\\n"
  printf "finish %s.\\n" "${0}"
  printf "\\n"
  printf "📝 You might need to reboot to reflect all changes.\\n"
  printf "Exit 0\\n"
}
