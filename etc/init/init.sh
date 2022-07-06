#!/bin/sh

# initial setup
#
# This file is responsible for setting up environment
# which is required before each dotfiles or os (mac, windows and so on...) run.
#
# e.g.) vim
#   * installing plugins


# stop if ${DOTPATH} is not set
# -----
# trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

if [ -z "${DOTPATH}" ]; then
    echo '$DOTPATH not set' >&2
    exit 1
fi


# execute
# -----
. ${DOTPATH}/etc/lib/log.sh

logging "OK $0" | sed "s ${DOTPATH} \${DOTPATH} g"
