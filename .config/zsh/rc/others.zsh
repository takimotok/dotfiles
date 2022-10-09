# color
# -----

# enable using colors
autoload -Uz colors
colors

# directory underlines style
# -----
# typeset -gA ZSH_HIGHLIGHT_STYLES
# ZSH_HIGHLIGHT_STYLES[path]=none
# ZSH_HIGHLIGHT_STYLES[path_prefix]=none

# complement
# -----

# enable commands completion
# zinit で呼ばれている ??
# autoload -Uz compinit
# compinit

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                 /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'


# os
# -----
case ${OSTYPE} in
  darwin*)
    #Mac用の設定
    export CLICOLOR=1
    alias ls='ls -G -F'
    # .DS_Store 削除
    #そもそも生成しないようにする: $ defaults write com.apple.desktopservices DSDontWriteNetworkStores true
    alias delds='find . -name ".DS_Store" -type f -ls -delete'
    alias delicon='find . -type f -name "Icon?" -print -delete;'
    ;;
  linux*)
    #Linux用の設定
    alias ls='ls -F --color=auto'
    ;;
esac


# fzf
# -----
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# direnv & assume-role
#
# For AWS-CLI assume-role & direnv
# -----
eval "$(direnv hook zsh)"
export EDITOR=vim


# gpg
# -----
export GPG_TTY=$(tty)

