#!/bin/zsh

# before loading package manager
# -----

# load package manager
# -----
source "${SHELDON_CONFIG_DIR}"/init.zsh

# after loading package manager
# -----
source "${ZDOTDIR}"/rc/*.zsh

# un-override source command
zsh-defer unfunction source

