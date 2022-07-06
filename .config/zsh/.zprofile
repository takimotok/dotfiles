# homebrew
# -----
# cf.) https://github.com/sei40kr/dotfiles/blob/23d39ca62788ab767b4e961d84e8edd28b0be255/config/zsh/zprofile
# brew 使用時, 遅延ロードしたいので fpath に関数を格納してゆく
if [[ "${OSTYPE}" == darwin* && -e /usr/local/bin/brew ]]; then
    local __brew_prefix=/usr/local

    path=( "${__brew_prefix}/bin" "${__brew_prefix}/sbin" "${path[@]}" )
    fpath=( "${__brew_prefix}/share/zsh/site-functions" "${fpath[@]}" )
    manpath=( "${__brew_prefix}/share/man" "${manpath[@]}" )
fi

# anyenv
# -----
export ANYENV_ROOT=${HOME}/.anyenv
if [ -d ${ANYENV_ROOT} ] ; then
  # git clone で inst. した場合は必要. 現状は brew 経由.
  # export PATH="${ANYENV_ROOT}/bin:$PATH"

  # load anyenv
  # eval "$(anyenv init - --no-rehash)"
  # https://zenn.dev/ktakayama/articles/27b9d6218ed2f0ee9992
  local __cache_root=${XDG_DATA_HOME}/zsh
  local __fileName="anyenv.cache"
  if ! [ -f ${__cache_root}/${__fileName} ] ; then
      anyenv init - --no-rehash > ${__cache_root}/${__fileName}
      zcompile ${__cache_root}/${__fileName}
  fi
  . ${__cache_root}/${__fileName}
fi

