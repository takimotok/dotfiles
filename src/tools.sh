#!/bin/bash

set -Ceu

(
  main() {
    _g_cd "$PROJECT_ROOT"

    # install some languages by mise
    . "${PROJECT_ROOT}/packages/mise/install.sh"

    # Cursor
    # create symlinks to other than $XDG_CONFIG_HOME
    # -----
    CURSOR_GLOBAL_PATH="${HOME}/Library/Application\ Support/Cursor/User"
    if [ ! -d "${CURSOR_GLOBAL_PATH}" ]; then
      mkdir -p "${CURSOR_GLOBAL_PATH}"
    fi

    CURSOR_DOTFILES_PATH="${PROJECT_ROOT}/.config/cursor"
    ln -sf "${CURSOR_DOTFILES_PATH}/settings.json" "${CURSOR_GLOBAL_PATH}/settings.json"
    ln -sf "${CURSOR_DOTFILES_PATH}/keybindings.json" "${CURSOR_GLOBAL_PATH}/keybindings.json"

    # avoid error:
    #   SecCodeCheckValidity: Error Domain=NSOSStatusErrorDomain Code=-67062 "(null)"
    codesign --force --deep --sign - /Applications/Cursor.app

    # @TODO: install extensions via extensions.txt
    # cf.) https://github.com/getcursor/cursor/issues/1985
    #
    # It seems the command below doesn't work:
    #   `$ cursor --install-extensions`

    # VSCode
    # -----
    VSCODE_GLOBAL_PATH="${HOME}/Library/Application\ Support/Code/User"
    if [ ! -d "${VSCODE_GLOBAL_PATH}" ]; then
      mkdir -p "${VSCODE_GLOBAL_PATH}"
    fi

    VSCODE_DOTFILES_PATH="${PROJECT_ROOT}/.config/vscode"
    xargs -L2 code --install-extension <"${VSCODE_DOTFILES_PATH}/extensions.txt"
    ln -sf "${VSCODE_DOTFILES_PATH}/settings.json" "${VSCODE_GLOBAL_PATH}/settings.json"
    ln -sf "${VSCODE_DOTFILES_PATH}/keybindings.json" "${VSCODE_GLOBAL_PATH}/keybindings.json"
  }

  main
)
