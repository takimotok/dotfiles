# 必要な file のみ zcompile する
#   $@ : 引数を全て展開
#   -nt: newer than
# https://qiita.com/GeneralD/items/73e31ab8cf9aa01e480f
() {
  local src
  for src in $@; do
    ([[ ! -e ${src}.zwc ]] || [ ${src:A} -nt ${src} ]) && zcompile ${src}
  done
} ${ZDOTDIR}/rc/*.zsh
