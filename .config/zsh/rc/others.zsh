#!/bin/zsh

# mise (rtx)
# -----
# for mise itself
export MISE_DATA_DIR="${XDG_DATA_HOME}/mise"
export MISE_CACHE_DIR="$XDG_CACHE_HOME/mise"
export MISE_INSTALL_PATH="${MISE_DATA_DIR}/bin"
export MISE_LOG_LEVEL="warn"
export MISE_EXPERIMENTAL=true

# eval "$(mise activate zsh)"
local cmd_mise_activate="mise activate zsh"
local cache_file_mise_activate="${MISE_CACHE_DIR}/activate.zsh"
local ref_file_mise="${XDG_CONFIG_HOME}/mise/config.toml"
cache_eval "${cache_file_mise_activate}" "${cmd_mise_activate}" "${ref_file_mise}"
source "${cache_file_mise_activate}"

# for installing php8.x
export PATH="${HOMEBREW_PREFIX}/opt/m4/bin:$PATH"

# fzf
# -----
zsh-defer [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# direnv & assume-role
#
# For AWS-CLI assume-role & direnv
# -----
# eval "$(direnv hook zsh)"
local cmd_mise_activate="direnv hook zsh"
local cache_file_direnv_hook="${XDG_CACHE_HOME}/direnv/hook.zsh"
local ref_file_direnv=""
cache_eval "${cache_file_direnv_hook}" "${cmd_mise_activate}" "${ref_file_direnv}"
source "${cache_file_direnv_hook}"

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
source "$HOME/.cargo/env"

# gh
# -----
# eval "$(gh completion -s zsh)"
local cmd_gh_completion="gh completion -s zsh"
local cache_file_gh_completion="${XDG_CACHE_HOME}/gh/completion.zsh"
local ref_file_gh="${XDG_CONFIG_HOME}/gh/config.yml"
cache_eval "${cache_file_gh_completion}" "${cmd_gh_completion}" "${ref_file_gh}"
source "${cache_file_gh_completion}"


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

