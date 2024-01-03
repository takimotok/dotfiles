#!/bin/bash

# setting for zprof restart zsh
# zmodload zsh/zprof && zprof

# init
# -----

# avoid registering duplicated paths重複パスを登録しない
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

# .zshrc read path
export ZDOTDIR=${XDG_CONFIG_HOME}/zsh
