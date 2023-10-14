#!/bin/bash

# Author: takimotok <takimoto.kengo.dev@gmail.com>
# Description: creating symbolic links.

# @param $1 DOTPATH string
# @param $2 TARGET_LINK string
# @return void
# -----
unlink_from_dotpath() {
  printf "unlinking ${2} ...\\n"
  unlink "${1}/${2}"

  if [ $? -gt 0 ]; then
    printf "Exit 1\\n"
    exit 1
  fi

  printf "done !\\n"
}

# @param $1 DOTPATH string
# @param $2 TARGET_LINK string
# @return void
# -----
link_to_dotpath() {
  printf "creating symbolic link ...\\n"
  printf "from:  ${2}\\n"
  printf "to:  ${1}\\n"

  ln -s "${2}" "${1}"

  if [ $? -gt 0 ]; then
    printf "Exit 1\\n"
    exit 1
  fi

  printf "done !\\n"
}
