# setting for zprof restart zsh
# zmodload zsh/zprof && zprof


# init
# -----

# avoid registering duplicated paths重複パスを登録しない
#   typeset: 変数宣言
#   -U: alias を変数展開しない (ユーザが定義した alias と干渉しないように)
typeset -U path PATH cdpath fpath manpath

# locale
export LANG=en_US.UTF-8

# xdg user directory env. variables
# -----
export XDG_CONFIG_HOME=${HOME}/.config
# only used for history
export XDG_DATA_HOME=${HOME}/.cache


# zsh
# -----
# .zshrc read path
export ZDOTDIR=${XDG_CONFIG_HOME}/zsh
# history file storing path
if [ ! -d ${XDG_DATA_HOME}/zsh ]; then
    mkdir -p ${XDG_DATA_HOME}/zsh
fi
if [ ! -f ${XDG_DATA_HOME}/zsh/history ]; then
    touch ${XDG_DATA_HOME}/zsh/history
fi
export HISTFILE=${XDG_DATA_HOME}/zsh/history

# vim
# -----

# change default .vimrc path
# export VIMINIT=":source ${XDG_CONFIG_HOME}"/vim/vimrc
# export VIMINIT=${XDG_CONFIG_HOME}/vim

