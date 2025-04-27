#!/bin/zsh

# before loading package manager
# -----
# Load autoload functions first
fpath=("${ZDOTDIR}"/autoload "${fpath[@]}")
autoload -Uz "${ZDOTDIR}"/autoload/*(:t)

# load package manager
# -----
source "${SHELDON_CONFIG_DIR}"/init.zsh

# after loading package manager
# -----
local non_lazy_rc=(
  "${ZDOTDIR}"/rc/00-brew.zsh
  "${ZDOTDIR}"/rc/01-zsh-modules.zsh
  # e.g.) need for alias.zsh
  #   - `setopt auto_cd`
  "${ZDOTDIR}"/rc/02-options.zsh
)
for non_lazy_rc_file in "${non_lazy_rc[@]}"; do
  source "${non_lazy_rc_file}"
done

local lazy_rc=(
  "${ZDOTDIR}"/rc/03-cdpath.zsh
  "${ZDOTDIR}"/rc/04-bindkeys.zsh
  "${ZDOTDIR}"/rc/05-core-packages.zsh
  "${ZDOTDIR}"/rc/06-plugins.zsh
  "${ZDOTDIR}"/rc/07-alias.zsh
  "${ZDOTDIR}"/rc/08-others.zsh
)
for rcfile in "${lazy_rc[@]}"; do
  zsh-defer source "${rcfile}"
done

# un-override source command
zsh-defer unfunction source

# debug
if (which zprof > /dev/null 2>&1) ;then
  zprof
fi

