#!/bin/bash

(main() {
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

            printf "\\n"
        done
    done

    printf "finish linking dotfiles.\\n"

}; main)
