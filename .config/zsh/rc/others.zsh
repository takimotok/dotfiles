#!/bin/bash

# color
# -----

# enable using colors
autoload -Uz colors
colors

# directory underlines style
# -----
# typeset -gA ZSH_HIGHLIGHT_STYLES
# ZSH_HIGHLIGHT_STYLES[path]=none
# ZSH_HIGHLIGHT_STYLES[path_prefix]=none

# complement
# -----

# enable commands completion
autoload -Uz compinit
compinit

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
  /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

# os
# -----
case ${OSTYPE} in
darwin*)
  #Mac用の設定
  export CLICOLOR=1
  alias ls='ls -G -F'
  # .DS_Store 削除
  #そもそも生成しないようにする: $ defaults write com.apple.desktopservices DSDontWriteNetworkStores true
  alias delds='find . -name ".DS_Store" -type f -ls -delete'
  alias delicon='find . -type f -name "Icon?" -print -delete;'
  ;;
linux*)
  #Linux用の設定
  alias ls='ls -F --color=auto'
  ;;
esac

# brew
# -----
if [ "$(uname -m)" = "arm64" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# mise (rtx)
# -----
# for installing php8.x
if [ "$(uname -m)" = 'arm64' ]; then
  export PATH="/opt/homebrew/opt/m4/bin:$PATH"
elif [ "$(uname -m)" = 'x86_64' ]; then
  export PATH="/usr/local/opt/m4/bin:$PATH"
fi

# for mise itself
export MISE_DATA_DIR=$XDG_DATA_HOME/mise
export MISE_CACHE_DIR=$XDG_CACHE_HOME/mise
export MISE_INSTALL_PATH=$XDG_DATA_HOME/mise/bin
export MISE_LOG_LEVEL="warn"
export MISE_EXPERIMENTAL=true
eval "$(mise activate zsh)"

# fzf
# -----
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# direnv & assume-role
#
# For AWS-CLI assume-role & direnv
# -----
eval "$(direnv hook zsh)"
export EDITOR=nvim

# gpg
# -----
export GPG_TTY=$(tty)

# mypy (python linter)
# -----
MYPY_CACHE_DIR="/dev/null"

# ruby
# -----
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@3)"

# rust
# -----
. "$HOME/.cargo/env"

# gh
# -----
eval "$(gh completion -s zsh)"

# 1Password
# -----
eval "$(op signin)"
eval "$(op completion zsh)"; compdef _op op

# vim & nvim
# -----
export VIMINIT='let $MYVIMRC = !has("nvim") ? "$XDG_CONFIG_HOME/vim/vimrc" : "$XDG_CONFIG_HOME/nvim/init.lua" | so $MYVIMRC'

# to show image inside nvim
# cf.) https://github.com/3rd/image.nvim?tab=readme-ov-file#installing-imagemagick
export DYLD_LIBRARY_PATH="$(brew --prefix)/lib:$DYLD_LIBRARY_PATH"
