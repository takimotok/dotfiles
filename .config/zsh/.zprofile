# homebrew
# -----
# cf.) https://github.com/sei40kr/dotfiles/blob/23d39ca62788ab767b4e961d84e8edd28b0be255/config/zsh/zprofile
# brew 使用時, 遅延ロードしたいので fpath に関数を格納してゆく
if [[ "${OSTYPE}" == darwin* && -e /usr/local/bin/brew ]]; then
  local __brew_prefix=/usr/local

  path=("${__brew_prefix}/bin" "${__brew_prefix}/sbin" "${path[@]}")
  fpath=("${__brew_prefix}/share/zsh/site-functions" "${fpath[@]}")
  manpath=("${__brew_prefix}/share/man" "${manpath[@]}")
fi

