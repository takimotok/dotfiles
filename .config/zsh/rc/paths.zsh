# for php
# -----
export PATH="$(phpenv which phpmd):$PATH"
export PATH="$(phpenv which phpcs):$PATH"

# for java
# -----
# export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-18.0.1.1.jdk/Contents/Home
export JAVA_HOME=`/usr/libexec/java_home -v "17"`
export CPPFLAGS="-I/usr/local/opt/openjdk@17/include"
export PATH="/usr/local/opt/openjdk@17/bin:$PATH"

# for go (ghq)
# -----
export GOPATH=$HOME
export PATH=$PATH:$GOPATH/bin

# for android
# -----
# adb (Android Debug Bridge)
export PATH=$PATH:/Users/takimoto/Library/Android/sdk/platform-tools

# android-commandlinetools
export ANDROID_SDK_ROOT="/usr/local/share/android-commandlinetools/cmdline-tools/latest/bin"
