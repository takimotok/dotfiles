#!/bin/zsh

# before loading package manager:
# load files under the rc dir.
# -----
. "${ZDOTDIR}"/functions/zcompile.zsh
. "${ZDOTDIR}"/rc/options.zsh

# load package manager
# -----
. "${ZDOTDIR}"/rc/sheldon.zsh
. "${ZDOTDIR}"/rc/plugins.zsh

# after loading package manager
# load files under the rc dir.
# -----
. "${ZDOTDIR}"/functions/user.zsh
. "${ZDOTDIR}"/rc/others.zsh
. "${ZDOTDIR}"/rc/paths.zsh
. "${ZDOTDIR}"/rc/cdpath.zsh
. "${ZDOTDIR}"/rc/alias.zsh
. "${ZDOTDIR}"/rc/bindkeys.zsh

