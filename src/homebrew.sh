#!/bin/bash

(main() {
  CMD_BREW="$(which brew)"
  if [ -z "${CMD_BREW}" ]; then
    printf "Homebrew not found.\\n"
    printf "installing Homebew ...\\n"

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    printf "done !\\n"

    printf "reloading shell ...\\n"
    exec "${SHELL}" -l
  fi
}; main)
