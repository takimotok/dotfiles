#!/bin/zsh

# cf.) rc/options.zsh:: setopt auto_cd
# -----

# aliases
# -----
alias ls='ls -G -F'
alias ll='ls -lah -D "%y%m%d %H:%M:%S"'

alias aria2c='aria2c -d $HOME/Desktop'

alias delds='pushd $(pwd) && cd ~ && find / -name ".DS_Store" -delete && popd'
alias delicon='pushd $(pwd) && cd ~ && find / -name "Icon\\r" -delete && popd'
alias desk='$HOME/Desktop'
alias dl='$HOME/Downloads'
# alias hosts='cat /private/etc/hosts'
# alias openssl=/usr/local/opt/openssl@1.1/bin/openssl
# alias vi=vim

# bat
alias bat='bat --style="numbers,grid"'

# mac の BSD系なので brew 経由で linux sed を inst.
alias sed='gsed'

# mac の grep は -P をサポートしていないので GNU grep を brew 経由で inst.
alias grep='ggrep'

# Cloud Storages
# cf.) rc/paths.zsh
alias gdrive="${G_DRIVE_PATH}/"
alias vault="${VAULT}/"
alias n="${NOTES}/"

alias tips="${NOTES}/dev/01_tips"
alias prj="${NOTES}/dev/02_prj"
alias wiki="${NOTES}/wiki"

alias hitotsuto="${VAULT}/areas/hitotsuto"

# iCloud
export ICLOUD="${HOME}/Library/Mobile\ Documents/com\~apple\~CloudDocs"
alias icloud="${ICLOUD}"
alias books="${ICLOUD}/Vault/books/"
alias imat="${ICLOUD}/Vault/books/IMAT/"

# restart touchbar@MBP2019
alias rt="sudo pkill TouchBarServer; sudo killall 'ControlSrip'"

# toggle Wi-fi
# -----
# cf.)
# - https://apple.stackexchange.com/questions/368046/how-to-check-status-of-wi-fi-adapter-through-command-line
# - https://www.mattcrampton.com/blog/managing_wifi_connections_using_the_mac_osx_terminal_command_line/
# - https://michaelsoolee.com/switch-wifi-macos-terminal/

# WIFI_STATUS="$(ifconfig en0 | awk '/status:/{print $2}')"
# @TODO: Raycast の script を作成してもいいかも
alias twn="networksetup -setairportpower en0 on"
alias twf="networksetup -setairportpower en0 off"

