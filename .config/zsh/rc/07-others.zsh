#!/bin/zsh

# mise (rtx)
#
# cf.) https://mise.jdx.dev/configuration.html#environment-variables
# -----
# for mise itself
export MISE_DATA_DIR="${XDG_DATA_HOME}/mise"
export MISE_CACHE_DIR="${XDG_CACHE_HOME}/mise"
export MISE_GLOBAL_CONFIG_ROOT="${XDG_CONFIG_HOME}/mise"
export MISE_GLOBAL_CONFIG_FILE="${MISE_GLOBAL_CONFIG_ROOT}/config.toml"
export MISE_LOG_FILE="${MISE_GLOBAL_CONFIG_ROOT}/mise.log"
export MISE_LOG_LEVEL="warn"

# mise requires dynamic environment updates, so we can't cache it reliably
# The _mise_hook function needs to run on every precmd to update PATH correctly
eval "$(mise activate zsh)"

# for installing php8.x
export PATH="${HOMEBREW_PREFIX}/opt/m4/bin:$PATH"

# fzf
# -----
[[ -f ~/.fzf.zsh ]] && zsh-defer source ~/.fzf.zsh

# direnv & assume-role
#
# For AWS-CLI assume-role & direnv
# -----
# eval "$(direnv hook zsh)"
local cmd_direnv_hook="direnv hook zsh"
local cache_file_direnv_hook="${XDG_CACHE_HOME}/direnv/hook.zsh"
local ref_file_direnv=""
cache_eval "${cache_file_direnv_hook}" "${cmd_direnv_hook}" "${ref_file_direnv}"
zsh-defer source "${cache_file_direnv_hook}"

# gpg
# -----
zsh-defer export GPG_TTY=$(tty)

# mypy (python linter)
# -----
export MYPY_CACHE_DIR="/dev/null"

# ruby
# -----
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=${HOMEBREW_PREFIX}/opt/openssl@3"

# rust
# -----
zsh-defer source "$HOME/.cargo/env"

# gh
# -----
# eval "$(gh completion -s zsh)"
local cmd_gh_completion="gh completion -s zsh"
local cache_file_gh_completion="${XDG_CACHE_HOME}/gh/completion.zsh"
local ref_file_gh="${XDG_CONFIG_HOME}/gh/config.yml"
cache_eval "${cache_file_gh_completion}" "${cmd_gh_completion}" "${ref_file_gh}"
zsh-defer source "${cache_file_gh_completion}"

# vim & nvim
# Do not confuse (n)vim env. variables with shell's one.
# We can not use `${}` syntax in vimrc.
# -----
export VIMINIT='let $MYVIMRC = !has("nvim") ? "$XDG_CONFIG_HOME/vim/vimrc" : "$XDG_CONFIG_HOME/nvim/init.lua" | so $MYVIMRC'

# to show image inside nvim
# cf.) https://github.com/3rd/image.nvim?tab=readme-ov-file#installing-imagemagick
export DYLD_LIBRARY_PATH="${HOMEBREW_PREFIX}/lib:$DYLD_LIBRARY_PATH"

# for go (ghq)
# -----
export GOPATH="${XDG_CONFIG_HOME}/go"
export PATH="${PATH}:${GOPATH}/bin"

# for android
# use command line tools
# -----
export ANDROID_HOME="${HOME}/Library/Android/sdk/"
export PATH="${ANDROID_HOME}/platform-tools":${PATH}
export PATH="${ANDROID_HOME}/emulator":${PATH}

# ↓ 実体をみたら下記 path は存在しなかった
# @TODO: もしかしたら cpu architecture によって異なるのかも
# export PATH=$ANDROID_HOME/tools:$PATH
# export PATH=$ANDROID_HOME/tools/bin:$PATH

# poetry (python package manager)
# -----
export POETRY_VIRTUALENVS_IN_PROJECT=true

# zk
# -----
export ZK_NOTEBOOK_DIR=${NOTES}

