# author: takimoto.kengo

# before zinit: load files under the rc dir.
# -----

# Enable Powerlevel10k instant prompt.
# Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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


# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# To customize prompt, run `p10k configure` or edit ~/projects/github.com/takimotok/dotfiles/.config/zsh/.p10k.zsh.
[[ ! -f ~/projects/github.com/takimotok/dotfiles/.config/zsh/.p10k.zsh ]] || source ~/projects/github.com/takimotok/dotfiles/.config/zsh/.p10k.zsh
