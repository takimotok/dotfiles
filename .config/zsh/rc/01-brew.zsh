#!/bin/zsh

# homebrew
# -----
if [[ "${OSTYPE}" != darwin* || "${+commands[brew]}" != 1 ]]; then
  return 0
fi

if [[ "$(uname -m)" == "arm64" ]]; then
  # apple sillicon
  export HOMEBREW_PREFIX="/opt/homebrew"
else
  # intel mac
  export HOMEBREW_PREFIX="/usr/local"
fi

export HOMEBREW_NO_ENV_HINTS=true
export HOMEBREW_BUNDLE_DUMP_NO_VSCODE=true
export HOMEBREW_BUNDLE_FILE_GLOBAL="${XDG_CONFIG_HOME}"/homebrew/Brewfile
export HOMEBREW_CACHE="${XDG_CACHE_HOME}"/Homebrew
export HOMEBREW_LOGS="${XDG_CACHE_HOME}"/Homebrew/Logs
export HOMEBREW_NO_ANALYTICS=true
export HOMEBREW_TEMP=/tmp

# @TODO: seems not working
# - `brew shellenv` does not work
# -----
# evaluate cached file
local cache_file="${HOMEBREW_CACHE}/01-brew.zsh"
local cmd="${HOMEBREW_PREFIX}/bin/brew shellenv"
local ref_file=$(get_newest_brew_ref_file)
cache_eval "${cache_file}" "${cmd}" "${ref_file}"
source "${cache_file}"

# lazy loading
# cf.) https://github.com/sei40kr/dotfiles/blob/23d39ca62788ab767b4e961d84e8edd28b0be255/config/zsh/zprofile
path=("${HOMEBREW_PREFIX}/bin" "${HOMEBREW_PREFIX}/sbin" "${path[@]}")
fpath=("${HOMEBREW_PREFIX}/share/zsh/site-functions" "${fpath[@]}")
manpath=("${HOMEBREW_PREFIX}/share/man" "${manpath[@]}")

