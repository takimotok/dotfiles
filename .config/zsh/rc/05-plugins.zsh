#!/bin/zsh

# plugin settings installed via sheldon
# cf.) .config/sheldon/plugins.toml

# theme: pure
#
# cf.) https://github.com/sindresorhus/pure
# -----
zstyle ':prompt:pure:path' color cyan
zstyle ':prompt:pure:git:*' color yellow

# zsh-completions
# -----
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

