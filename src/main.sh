#!/bin/bash

DOTFILES_PATH="${DOTPATH}/projects/github.com/takimotok/dotfiles"

. ./src/libs/*

printf "start %s...\\n" "${0}"
printf "\\n"

# Homebrew
# ----------
# CMD_BREW="$(which brew)"
# if [ -z "${CMD_BREW}" ]; then
#     printf "Homebrew not found.\\n"
#     printf "installing Homebew ...\\n"
#
#     /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
#
#     printf "done !\\n"
#
#     printf "reloading shell ...\\n"
#     exec "${SHELL}" -l
# fi

# ghq
# ----------
printf "setting ghq ...\\n"

GHQ_ROOT="$(ghq root)"
if [ -z "${GHQ_ROOT}" ]; then
    printf "ghq root not found.\\n"
    printf "Exit 1\\n"

    exit 1
fi

EXPECTED_GHQ_ROOT="${HOME}/projects"
if [ "${GHQ_ROOT}" != "${EXPECTED_GHQ_ROOT}" ]; then
    printf "ghq.root is not as expected.\\n"
    printf "expected: %s\\n" "${EXPECTED_GHQ_ROOT}"
    printf "actual: %s\\n" "${GHQ_ROOT}"
    printf "Exit 1\\n"

    exit 1
fi

printf "done !\\n"
printf "\\n"


# link dotfiles to $DOTPATH
# ----------
printf "start linking dotfiles ...\\n"
printf "\\n"

DOTPATH="${HOME}"
DOTFILES_PATH="${DOTPATH}/projects/github.com/takimotok/dotfiles"
files="$(find "${DOTFILES_PATH}"/.config -maxdepth 2 -type f)"
dotfiles=(".editorconfig" ".textlintrc" ".tmux.conf" ".vimrc" ".zshenv")
for file in ${files}; do
    file_name=$(printf "%s" "${file}" | sed -r "s/^.+\/(\.?.+)?$/\1/")
    for dotfile in "${dotfiles[@]}"; do
        if [[ "${file_name}" != "${dotfile}" ]]; then
            continue
        fi

        if [ -L "${DOTPATH}/${dotfile}" ]; then
            printf "%s already exists.\\n" "${dotfile}"

            unlink_from_dotpath "${DOTPATH}" "${dotfile}"
        fi
        if [ ! -L "${DOTPATH}/${dotfile}" ]; then
            printf "%s not found.\\n" "${dotfile}"

            link_to_dotpath "${DOTPATH}" "${file}"
        fi
    done

    printf "\\n"
done

# EOF
# ----------
printf "all tasks done !\\n"
printf "finish %s...\\n" "${0}"
printf "\\n"
printf "note: You might restart shell to reflect settings.\\n"

exit 0
