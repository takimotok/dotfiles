#!/bin/zsh

# zsh
# -----
# .zshrc reading path
export ZDOTDIR=${XDG_CONFIG_HOME}/zsh

# fpath
export FPATH="${ZDOTDIR}/autoload/:${FPATH}"

# sheldon
# -----
export SHELDON_CONFIG_DIR="${ZDOTDIR}/sheldon"
export SHELDON_CONFIG_FILE="${SHELDON_CONFIG_DIR}/plugins.toml"
export SHELDON_DATA_DIR="${XDG_DATA_HOME}/sheldon"
export SHELDON_CACHE_DIR="${XDG_CACHE_HOME}/sheldon"

# homebrew
# -----
# cf.) https://github.com/sei40kr/dotfiles/blob/23d39ca62788ab767b4e961d84e8edd28b0be255/config/zsh/zprofile
# brew 使用時, 遅延ロードしたいので fpath に関数を格納してゆく
if [[ "${OSTYPE}" == darwin* && "${+commands[brew]}" == 1 ]]; then
  export HOMEBREW_PREFIX=$(brew --prefix)

  path=("${HOMEBREW_PREFIX}/bin" "${HOMEBREW_PREFIX}/sbin" "${path[@]}")
  fpath=("${HOMEBREW_PREFIX}/share/zsh/site-functions" "${fpath[@]}")
  manpath=("${HOMEBREW_PREFIX}/share/man" "${manpath[@]}")
fi

