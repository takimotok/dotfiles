#!/bin/zsh

# plugin settings installed via sheldon
# cf.) .config/zsh/sheldon/plugins.toml

# deferring `$ sheldon source`
# -----
# update sheldon_cache_file when:
# - cache file does not exist
# - ${SHELDON_CONFIG_FILE} is newer than cache file
local cache_file="${SHELDON_CACHE_DIR}/sheldon.zsh"
local cmd="sheldon source"
local ref_file="${SHELDON_CONFIG_FILE}"
cache_eval "${cache_file}" "${cmd}" "${ref_file}"
ensure_zcompiled "${cache_file}"
source "${cache_file}"

