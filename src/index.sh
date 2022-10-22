#!/bin/bash

. ./src/libs/*

. ./src/app/start_message.sh
# . ./src/app/homebrew.sh
. ./src/app/ghq.sh
. ./src/app/wezterm.sh
. ./src/app/link_dotfiles_to_dotpath.sh
. ./src/app/link_directories_to_config_path.sh
. ./src/app/finish_message.sh

exit 0
