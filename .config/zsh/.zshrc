# author: takimoto.kengo

# before zinit: load files under the rc dir.
# -----

# load files under the rc dir.
. ${ZDOTDIR}/functions/zcompile.zsh
. ${ZDOTDIR}/rc/before_zinit.zsh


# zinit
# -----
. ${ZDOTDIR}/rc/zinit_installer.zsh


# after zinit: load files under the rc dir.
# -----

# load files
. ${ZDOTDIR}/rc/plugin.zsh
. ${ZDOTDIR}/functions/bindkeys.zsh
. ${ZDOTDIR}/rc/others.zsh
. ${ZDOTDIR}/rc/paths.zsh
. ${ZDOTDIR}/rc/cdpath.zsh
. ${ZDOTDIR}/rc/alias.zsh
. ${ZDOTDIR}/rc/bindkeys.zsh
