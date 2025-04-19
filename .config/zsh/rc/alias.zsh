#!/bin/zsh

# aliases
# -----
abbr aria2c='aria2c -d $HOME/Desktop'

abbr delds='pushd $(pwd) && cd ~ && find / -name ".DS_Store" -delete && popd'
abbr delicon='pushd $(pwd) && cd ~ && find / -name "Icon\\r" -delete && popd'
abbr desk='$HOME/Desktop'
abbr dl='$HOME/Downloads'
abbr hosts='cat /private/etc/hosts'
abbr ll='ls -lah -D "%y%m%d %H:%M:%S"'
# abbr openssl=/usr/local/opt/openssl@1.1/bin/openssl
abbr vi=vim

# bat
abbr bat='bat --style="numbers,grid"'

# mac の BSD系なので brew 経由で linux sed を inst.
abbr sed='gsed'

# mac の grep は -P をサポートしていないので GNU grep を brew 経由で inst.
abbr grep='ggrep'

# Cloud Storages
# cf.) rc/paths.zsh
abbr gdrive="${G_DRIVE_PATH}/"
abbr vault="${VAULT}/"
abbr n="${NOTES}/"

abbr tips="${NOTES}/dev/01_tips"
abbr prj="${NOTES}/dev/02_prj"
abbr wiki="${NOTES}/wiki"

abbr hitotsuto="${VAULT}/areas/hitotsuto"

# iCloud
abbr icloud="${HOME}/Library/Mobile\ Documents/com\~apple\~CloudDocs"

# restart touchbar@MBP2019
abbr rt="sudo pkill TouchBarServer; sudo killall 'ControlSrip'"

# toggle Wi-fi
# -----
# cf.)
# - https://apple.stackexchange.com/questions/368046/how-to-check-status-of-wi-fi-adapter-through-command-line
# - https://www.mattcrampton.com/blog/managing_wifi_connections_using_the_mac_osx_terminal_command_line/
# - https://michaelsoolee.com/switch-wifi-macos-terminal/

# WIFI_STATUS="$(ifconfig en0 | awk '/status:/{print $2}')"
# @TODO: Raycast の script を作成してもいいかも
abbr twn="networksetup -setairportpower en0 on"
abbr twf="networksetup -setairportpower en0 off"

