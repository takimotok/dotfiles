#!/bin/zsh

# 1Password
# -----
# export OP_DEBUG=true
zsh-defer eval "$(op signin)"

# always read cached file
# e.g.) original command
#   eval "$(op completion zsh)"; compdef _op op
local cmd_op_completion_zsh="op completion zsh"
local cache_file_op_completion_zsh="${XDG_CACHE_HOME}/op/op_completion.zsh"
local ref_file_op_completion_zsh=""
cache_eval "${cache_file_op_completion_zsh}" "${cmd_op_completion_zsh}" "${ref_file_op_completion_zsh}"
source "${cache_file_op_completion_zsh}"
compdef _op op

# always read cached file
local cmd_op_read="op read op://development/Google/DRIVE/username --no-newline"
local cache_file_google="${XDG_CACHE_HOME}/op/google.zsh"
local ref_file_op_read=""
cache_eval "${cache_file_google}" "${cmd_op_read}" "${ref_file_op_read}"
ensure_zcompiled "${cache_file_google}"


# Cloud Strages
# -----
export CLOUD_STRAGE="${HOME}/Library/CloudStorage"
export G_ACCOUNT=$(cat "${cache_file_google}")
export G_DRIVE_PATH="${CLOUD_STRAGE}/GoogleDrive-${G_ACCOUNT}/My\ Drive"
export VAULT="${G_DRIVE_PATH}/Vault"
export NOTES="${G_DRIVE_PATH}/Notes"

