#!/bin/zsh

# color
# -----
# enable using colors
autoload -Uz colors && colors

# make ls command color to cyan
# cf.) https://qiita.com/sakurasou/items/10156a46fb7e2d1c300f
export LSCOLORS=gxfxcxdxbxegedabagacad
export CLICOLOR=1

# enable commands completion
#
# cf.) https://gist.github.com/ctechols/ca1035271ad134841284
# -----
autoload -Uz compinit
if [ "$(date +'%j')" != "$(stat -f '%Sm' -t '%j' ${ZDOTDIR}/.zcompdump 2>/dev/null)" ]; then
    rm ${ZDOTDIR}/.zcompdump
    compinit
else
    compinit -C
fi

