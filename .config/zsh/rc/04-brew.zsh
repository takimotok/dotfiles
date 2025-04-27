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
local cache_file="${HOMEBREW_CACHE}/brew.zsh"
local cmd="${HOMEBREW_PREFIX}/bin/brew shellenv"
local ref_file=$(get_newest_brew_ref_file)
cache_eval "${cache_file}" "${cmd}" "${ref_file}"
source "${cache_file}"

# brew-file
# -----
export HOMEBREW_BREWFILE=${HOMEBREW_BUNDLE_FILE_GLOBAL}
if [[ -f ${HOMEBREW_PREFIX}/etc/brew-wrap ]]; then
  zsh-defer source ${HOMEBREW_PREFIX}/etc/brew-wrap

  _post_brewfile_update () {
    brew file update
  }
fi

