#!/bin/zsh

# like emacs
#
# ^r (or ^s)で履歴検索をするときに * でワイルドカードを使用出来るようにする
# -----
bindkey -e
bindkey '^R' history-incremental-pattern-search-backward
bindkey "^S" history-incremental-search-forward

# for user defined functions
# cf) .config/zsh/functions/user.zsh
# -----
bindkey '^]' list-ghq-with-peco
bindkey '^r' select-history

