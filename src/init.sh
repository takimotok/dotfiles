#!/bin/bash

set -Ceu

(
  main() {
    _g_cd "$PROJECT_ROOT"

    # check if the os is macOS
    _is_macos
    _exit_with_errors "$?"

    # set zsh
    chsh -s "$(which zsh)"
    _exit_with_errors "$?"

    # install Rosetta 2 for Apple Silicon
    if [ "$(uname -m)" = "arm64" ]; then
      /usr/sbin/softwareupdate \
        --install-rosetta \
        --agree-to-license
    fi

    # install command line tools
    if xcode-select --print-path &>/dev/null; then
      echo "🍎 Command line tools are already installed."
    else
      xcode-select --install
    fi
    _exit_with_errors "$?"

    # install brew
    # @see: .config/zsh/rc/others.zsh#brew
    if which brew &>/dev/null; then
      echo "🍺 Homebrew is already installed."
    else
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" >/dev/null
    fi
    _exit_with_errors "$?"

    # install brew packages from Brewfile
    brew bundle --file=./packages/Brewfile
    _exit_with_errors "$?"
  }

  main
)
