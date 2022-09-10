# cdpath
# -----
cdpath=(
    ${HOME}/Desktop/prj(N-/)
    $cdpath
)

# for php
# -----
export PATH="$(phpenv which phpmd):$PATH"
export PATH="$(phpenv which phpcs):$PATH"

# for java
# -----
export PATH="/usr/local/opt/openjdk@17/bin:$PATH"
