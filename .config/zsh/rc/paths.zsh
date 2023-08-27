# plugings for pip through pyenv ( anyenv )
# -----
# export PATH="/Users/takimoto/.anyenv/envs/pyenv/versions/**/bin:$PATH"

# for php
# -----
# export PATH="$(phpenv which phpmd):$PATH"
# export PATH="$(phpenv which phpcs):$PATH"

# for java
# -----
# export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-18.0.1.1.jdk/Contents/Home
export JAVA_HOME=$(/usr/libexec/java_home -v "17")
export CPPFLAGS="-I/usr/local/opt/openjdk@17/include"
export PATH="/usr/local/opt/openjdk@17/bin:$PATH"

# for go (ghq)
# -----
export GOPATH=$HOME
export PATH=$PATH:$GOPATH/bin

# for android
# use command line tools
# -----
export ANDROID_USER_HOME=$HOME/.android
export ANDROID_HOME=$HOME/Library/Android/sdk/
export PATH=$ANDROID_HOME/platform-tools:$PATH
export PATH=$ANDROID_HOME/tools:$PATH
export PATH=$ANDROID_HOME/tools/bin:$PATH

# poetry (python package manager)
# -----
export PATH="/usr/local/opt/poetry/bin:$PATH"
