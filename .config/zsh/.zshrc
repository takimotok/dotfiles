# author: takimoto.kengo

# before zinit: load files under the rc dir.
# -----

# load files under the rc dir.
. ${ZDOTDIR}/functions/zcompile.zsh
. ${ZDOTDIR}/rc/before_zinit.zsh


# zinit
# -----

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk


# after zinit
# -----

# load files under the rc dir.
. ${ZDOTDIR}/rc/path.zsh
. ${ZDOTDIR}/rc/plugin.zsh
. ${ZDOTDIR}/rc/alias.zsh
. ${ZDOTDIR}/rc/others.zsh


# profiling
# -----

# if (which zprof > /dev/null 2>&1) ;then
#   zprof
# fi
