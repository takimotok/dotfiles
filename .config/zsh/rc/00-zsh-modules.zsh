#!/bin/zsh

# color
# -----
# enable using colors
autoload -Uz colors && colors

# make ls command color to cyan
# cf.) https://qiita.com/sakurasou/items/10156a46fb7e2d1c300f
export LSCOLORS=gxfxcxdxbxegedabagacad
export CLICOLOR=1

# complement
# -----
# enable commands completion
autoload -Uz compinit && compinit

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path \
  /usr/local/sbin \
  /usr/local/bin \
  /usr/sbin \
  /usr/bin \
  /sbin \
  /bin \
  /usr/X11R6/bin

# ps コマンドのプロセス名補完
# zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

