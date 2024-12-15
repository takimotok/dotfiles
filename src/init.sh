#!/bin/bash

set -Ceu

(
  main() {
    if [ ! -d "$PROJECT_ROOT" ]; then
      mkdir -p "$PROJECT_ROOT"
    fi
    _g_cd "$PROJECT_ROOT"

    # check if the os is macOS
    _is_macos
    _exit_with_errors "$?"

    # enable Stow to access
    if [ ! -d "$HOME/.config" ]; then
      mkdir -p "$HOME/.config"
    elif [ -d "$HOME/.config/zed" ]; then
      rm -rf "$HOME/.config/zed"
    fi

    # enable 1Password-cli to access
    if [ ! -d "$HOME/.ssh" ]; then
      mkdir -p "$HOME/.ssh"
    fi

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
      if [ "$(uname -m)" = "arm64" ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
        /opt/homebrew/bin/brew tap --force homebrew/cask
      fi
    fi
    _exit_with_errors "$?"

    # install brew packages from Brewfile
    brew bundle --file=./packages/Brewfile
    _exit_with_errors "$?"

    # WezTerm
    # -----
    # install `wezterm` TERM definition
    # **NOTE** need to set `term = "wezterm"` in config file.
    # cf.) https://wezfurlong.org/wezterm/config/lua/config/term.html
    if [ ! -d "$HOME/.terminfo" ]; then
      tempfile=$(mktemp) &&
        curl -o "$tempfile" https://raw.githubusercontent.com/wez/wezterm/main/termwiz/data/wezterm.terminfo &&
        tic -x -o ~/.terminfo "$tempfile" &&
        rm "$tempfile"
    fi

    # install fonts
    FONT_NAME="LigalexMono"
    TARGET_URL="https://github.com/ToxicFrog/Ligaturizer/releases/download/v5/LigaturizedFontsWithCharacters.zip"
    TARGET_FILE_NAME="LigaturizedFontsWithCharacters.zip"

    if [ ! -f "$HOME/Library/Fonts/$FONT_NAME".ttf ]; then
      temp_dir=$(mktemp -d) &&
        curl -fsSL -o "$temp_dir/$TARGET_FILE_NAME" "$TARGET_URL" &&
        unzip -n "$temp_dir/LigaturizedFontsWithCharacters.zip" -d "$temp_dir" &&
        cp "$temp_dir/$FONT_NAME"* "$HOME/Library/Fonts/" &&
        rm -rf "$temp_dir"
    fi
  }

  main
)
