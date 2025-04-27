#!/bin/zsh

# color
# -----
# enable using colors
autoload -Uz colors && colors

# make ls command color to cyan
# cf.) https://qiita.com/sakurasou/items/10156a46fb7e2d1c300f
export LSCOLORS=gxfxcxdxbxegedabagacad
export CLICOLOR=1

# enable command completions
#
# cf.) https://gist.github.com/ctechols/ca1035271ad134841284
# -----
# cf.)
#   - https://github.com/sei40kr/dotfiles/blob/23d39ca62788ab767b4e961d84e8edd28b0be255/config/zsh/zprofile
#   - https://homebrew-file.readthedocs.io/en/latest/completion.html
path=("${HOMEBREW_PREFIX}/bin" "${HOMEBREW_PREFIX}/sbin" "${path[@]}")
fpath=(
  "${HOMEBREW_PREFIX}"/share/zsh/site-functions
  "${HOMEBREW_PREFIX}"/etc/brew-wrap
  "${fpath[@]}"
)
manpath=("${HOMEBREW_PREFIX}/share/man" "${manpath[@]}")

autoload -Uz compinit
if [ "$(date +'%j')" != "$(stat -f '%Sm' -t '%j' ${ZDOTDIR}/.zcompdump 2>/dev/null)" ]; then
    rm ${ZDOTDIR}/.zcompdump
    compinit
else
    compinit -C
fi

