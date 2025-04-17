#!/bin/bash

function list-ghq-with-peco() {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N list-ghq-with-peco

function select-history() {
  # show selected histories to buffer
  BUFFER=$(history -n -r 1 | fzf --reverse --query="$LBUFFER" --prompt="> ")
  # set cursor position to end of the line
  CURSOR=${#BUFFER}
}
zle -N select-history

# memo: use `$ cd ./**<TAB>` instead
#
# fd - cd to selected directory
# https://qiita.com/kamykn/items/aa9920f07487559c0c7e
# function fcd() {
#   local dir
#   dir=$(find ${1:-.} -path '*/\.*' -prune \
#     -o -type d -print 2>/dev/null | fzf +m) &&
#     cd "$dir"
# }
# zle -N fcd

