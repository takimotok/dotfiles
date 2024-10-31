#!/bin/bash

# [zinit commands](https://github.com/zdharma/zinit#zinit-commands)
#
#   snippet: `source` local or remote file
#

# highlite commands
# -----
#   !: suppress messages when loaded
#   0: wait 0s after zsh starts
# zinit ice wait'!0'
# zinit light zsh-users/zsh-syntax-highlighting
# ↑ zsh 起動時に一瞬文字列が表示されるため ↓ に変更
# ただ, theme (pure) を使っているので不要かもしれない
zinit ice wait"0" lucid atinit"zpcompinit; zpcdreplay"
zinit light "zdharma/fast-syntax-highlighting"

# commands completions
# -----
zinit ice wait'!0'
zinit light zsh-users/zsh-completions

# commands suggestions based on history
# -----
zinit light zsh-users/zsh-autosuggestions

# theme: pure
# cf.) https://github.com/sindresorhus/pure
# -----
zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure

# path color
# https://github.com/sindresorhus/pure#example
zstyle :prompt:pure:path color cyan
zstyle ':prompt:pure:git:*' color yellow

# ls command color
# https://qiita.com/sakurasou/items/10156a46fb7e2d1c300f
export LSCOLORS=gxfxcxdxbxegedabagacad

# fzf
# FZF_DEFAULT_OPTS='--height=15 --reverse --inline-info --color=dark --color=fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#d858fe --color=info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef'
# zinit ice has'fzf' multisrc'shell/{completion,key-bindings}.zsh'
# zinit light junegunn/fzf
