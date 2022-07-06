#!/bin/bash

# Author: takimotok <takimoto.kengo.dev@gmail.com>
# Description: os type detecting functions for initial setup.

export PLATFORM

# @param string
# @return string
# -----
filter_lower_case() {
  if [ $# -ne 1 ]; then
    # log 入れたほうがいいかね
    return 1
  fi

  if [ -f "$1" -a -r "$1" ]; then
    cat "$1"
  else
    echo "$1"
  fi | tr "[:upper:]" "[:lower:]"
}

ostype(){
  uname | filter_lower_case
}

# os_detect export the PLATFORM variable as you see fit
os_detect() {
  export PLATFORM
  case "$(ostype)" in
    *'linux'*)  PLATFORM='linux'   ;;
    *'darwin'*) PLATFORM='osx'     ;;
    *'bsd'*)    PLATFORM='bsd'     ;;
    *)          PLATFORM='unknown' ;;
  esac
}

get_os(){
  os_detect
  echo $PLATFORM
}


# is_osx returns true if running OS is Macintosh
is_osx() {
  os_detect
  if [ "$PLATFORM" = "osx" ]; then
      return 0
  else
      return 1
  fi
}
alias is_mac=is_osx

# is_linux returns true if running OS is GNU/Linux
is_linux() {
  os_detect
  if [ "$PLATFORM" = "linux" ]; then
      return 0
  else
      return 1
  fi
}

# is_bsd returns true if running OS is FreeBSD
is_bsd() {
  os_detect
  if [ "$PLATFORM" = "bsd" ]; then
      return 0
  else
      return 1
  fi
}

