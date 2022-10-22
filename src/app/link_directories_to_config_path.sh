#!/bin/bash

(main() {
    printf "start linking directories ...\\n"
    printf "\\n"

    CONFIG_PATH="${HOME}/.config"
    DOTFILES_PATH="${HOME}/projects/github.com/takimotok/dotfiles"
    directories="$(find "${DOTFILES_PATH}"/.config -maxdepth 1 -type d)"
    target_directories=("zsh" "wezterm")
    for dir in ${directories}; do
        dir_name=$(printf "%s" "${dir}" | sed -r "s/^.+\/(\.?.+)?$/\1/")
        for target_dir in "${target_directories[@]}"; do
            if [[ "${dir_name}" != "${target_dir}" ]]; then
                continue
            fi
            if [[ -L "${CONFIG_PATH}/${target_dir}" || -e "${CONFIG_PATH}/${target_dir}" ]]; then
                printf "%s already exists.\\n" "${target_dir}"
                printf "WARNING!! You might have to copy %s dir. into dotfiles directory and try again !.\\n" "${target_dir}"

                printf "Exit 1\\n"
                exit 1
            fi
            if [ ! -L "${CONFIG_PATH}/${target_dir}" ]; then
                printf "%s not found.\\n" "${target_dir}"
                printf "start making symlink...\\n"

                link_to_dotpath "${CONFIG_PATH}" "${dir}"
            fi

            printf "\\n"
        done
    done

    printf "finish linking directories.\\n"

}; main)
