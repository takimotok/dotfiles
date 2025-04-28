#!/bin/zsh

# debug
# zmodload zsh/zprof && zprof

# avoid registering duplicated paths
#   typeset: 変数宣言
#   -U: alias を変数展開しない (ユーザが定義した alias と干渉しないように)
typeset -U path PATH cdpath fpath manpath

# locale
export LANG=en_US.UTF-8

# xdg user directory env. variables
# cf.) https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
# -----
export XDG_CONFIG_HOME=${HOME}/.config
export XDG_CACHE_HOME=${HOME}/.cache
export XDG_DATA_HOME=${HOME}/.local/share
export XDG_STATE_HOME=${HOME}/.local/state

# zsh env. variables
# -----
# .zshrc reading path
export ZDOTDIR=${XDG_CONFIG_HOME}/zsh

# package manager (sheldon)
# -----
export SHELDON_CONFIG_DIR="${ZDOTDIR}/sheldon"
export SHELDON_CONFIG_FILE="${SHELDON_CONFIG_DIR}/plugins.toml"
export SHELDON_DATA_DIR="${SHELDON_CONFIG_DIR}"
export SHELDON_CACHE_DIR="${XDG_CACHE_HOME}/sheldon"

# editor
# -----
export EDITOR=nvim

