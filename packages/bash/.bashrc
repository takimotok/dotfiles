# bash-completion
[ -f $(brew --prefix)/share/bash-completion/bash_completion ] && . $(brew --prefix)/share/bash-completion/bash_completion

# for git
PATH=$(echo /usr/local/opt/git)/bin:$PATH
export PATH

# git completion
## prompt に branch 名表示
[ -f /usr/local/etc/bash_completion ] && \
    . /usr/local/etc/bash_completion
BREW_SCRIPTS="$(brew --prefix)/etc/bash_completion.d"
[ -f "$BREW_SCRIPTS/git-prompt.sh" ] && \
    . "$BREW_SCRIPTS/git-prompt.sh" && \
    PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '

# git command 補完
GIT_COMPLETION_PATH=$(find /usr/local/Cellar/git/ -name "git-completion.bash" | grep -v "zsh")
source ${GIT_COMPLETION_PATH}

# anyenv
PATH="$HOME/.anyenv/bin:$PATH"
export PATH
eval "$(anyenv init -)"

## for phpenv (openSsl)
PATH=$(brew --prefix openssl)"/bin:$PATH"
export PATH
PATH=$(brew --prefix bison)"/bin:$PATH"
export PATH
PATH=$(phpenv prefix)/composer/vendor"/bin:$PATH"
export PATH

# for docker
PATH="/Applications/Docker.app/Contents/Resources/bin:$PATH"
export PATH

# locale
export LC_ALL=en_US.UTF-8
export LANG=ja_JP.UTF-8

# alias
alias ll='ls -lahFG'
alias tips='cd ~/GoogleDrive/01_Tips/'
alias desk='cd $HOME/Desktop'
alias dl='cd $HOME/Downloads'
alias prj='cd $HOME/Desktop/prj'

# .DS_Store 削除
# そもそも生成しないようにする: $ defaults write com.apple.desktopservices DSDontWriteNetworkStores true
alias delds='find . -name ".DS_Store" -type f -ls -delete'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
