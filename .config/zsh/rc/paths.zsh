#!/bin/bash

# for go (ghq)
# -----
export GOPATH=$XDG_CONFIG_HOME/go
export PATH=$PATH:$GOPATH/bin

# for android
# use command line tools
# -----
export ANDROID_USER_HOME=$XDG_CONFIG_HOME/android
export ANDROID_HOME=$HOME/Library/Android/sdk/
export PATH=$ANDROID_HOME/platform-tools:$PATH
export PATH=$ANDROID_HOME/tools:$PATH
export PATH=$ANDROID_HOME/tools/bin:$PATH

# poetry (python package manager)
# -----
export POETRY_VIRTUALENVS_IN_PROJECT=true
