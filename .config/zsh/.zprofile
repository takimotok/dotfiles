#!/bin/zsh

# zsh env. variables
# -----
# .zshrc reading path
export ZDOTDIR=${XDG_CONFIG_HOME}/zsh

# zsh histories
# -----
# メモリに保存される履歴件数
export HISTSIZE=1000000
# 履歴ファイルに保存される履歴件数
export SAVEHIST=1000000
# 履歴ファイル保存 file
export HISTFILE=${ZDOTDIR}/.zsh_history

# zsh functions
# -----
# set zle
zle -N list-ghq-with-peco
zle -N select-history

# sheldon
# -----
export SHELDON_CONFIG_DIR="${ZDOTDIR}/sheldon"
export SHELDON_CONFIG_FILE="${SHELDON_CONFIG_DIR}/plugins.toml"
export SHELDON_DATA_DIR="${SHELDON_CONFIG_DIR}"
export SHELDON_CACHE_DIR="${XDG_CACHE_HOME}/sheldon"

# editor
# -----
export EDITOR=nvim

