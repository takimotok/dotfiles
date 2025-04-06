#!/bin/bash

# homebrew
# -----
# cf.) https://github.com/sei40kr/dotfiles/blob/23d39ca62788ab767b4e961d84e8edd28b0be255/config/zsh/zprofile
# brew 使用時, 遅延ロードしたいので fpath に関数を格納してゆく
if [[ "${OSTYPE}" == darwin* && -e /usr/local/bin/brew ]]; then
  # HOMEBREW_PREFIX=/opt/homebrew
  path=("${HOMEBREW_PREFIX}/bin" "${HOMEBREW_PREFIX}/sbin" "${path[@]}")
  fpath=("${HOMEBREW_PREFIX}/share/zsh/site-functions" "${fpath[@]}")
  manpath=("${HOMEBREW_PREFIX}/share/man" "${manpath[@]}")
fi
