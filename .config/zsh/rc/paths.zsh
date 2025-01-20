#!/bin/bash

# for Cloud Strages
# -----
export CLOUD_STRAGE="${HOME}/Library/CloudStorage"
export G_ACCOUNT=$(op read op://development/Google/DRIVE/username --no-newline)

export G_DRIVE_PATH="${CLOUD_STRAGE}/GoogleDrive-${G_ACCOUNT}/My\ Drive"
export VAULT="${G_DRIVE_PATH}/Vault"
export NOTES="${G_DRIVE_PATH}/Notes"
export GOOD_NOTES="${G_DRIVE_PATH}/GoodNotes"

# for go (ghq)
# -----
export GOPATH=$XDG_CONFIG_HOME/go
export PATH=$PATH:$GOPATH/bin

# for android
# use command line tools
# -----
export ANDROID_HOME=$HOME/Library/Android/sdk/
export PATH=$ANDROID_HOME/platform-tools:$PATH
export PATH=$ANDROID_HOME/tools:$PATH
export PATH=$ANDROID_HOME/tools/bin:$PATH

# poetry (python package manager)
# -----
export POETRY_VIRTUALENVS_IN_PROJECT=true

# zk
# -----
export ZK_NOTEBOOK_DIR=${NOTES}
