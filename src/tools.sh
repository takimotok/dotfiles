#!/bin/bash

set -Ceu

(
  main() {
    _g_cd "$PROJECT_ROOT"

    # install some languages by mise
    . ./packages/mise/install.sh

    # create symlinks to other than $XDG_CONFIG_HOME
    # -----
    # Cursor
    CURSOR_PATH="${HOME}/Library/Application\ Support/Cursor/User"
    if [ ! -d "${CURSOR_PATH}" ]; then
      mkdir -p "${CURSOR_PATH}"
    fi

    ln -sf "${PWD}/.config/cursor/settings.json" "${CURSOR_PATH}/settings.json"

    # avoid error:
    #   SecCodeCheckValidity: Error Domain=NSOSStatusErrorDomain Code=-67062 "(null)"
    codesign --force --deep --sign - /Applications/Cursor.app

    # @TODO: install extensions extensions.txt
    # cf.) https://github.com/getcursor/cursor/issues/1985
    #
    # Ut seems the command below doesn't work:
    #   `$ cursor --install-extensions`
  }

  main
)
