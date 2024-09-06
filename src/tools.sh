#!/bin/bash

set -Ceu

(
  main() {
    _g_cd "$PROJECT_ROOT"

    # install some languages by mise
    mise plugin uninstall awscli && mise plugin install awscli https://github.com/MetricMike/asdf-awscli \
      && mise plugin uninstall ghq && mise plugin install ghq https://github.com/kajisha/asdf-ghq \
      && mise plugin uninstall jq && mise plugin install jq https://github.com/lsanwick/asdf-jq \
      && mise plugin uninstall lua && mise plugin install lua https://github.com/Stratus3D/asdf-lua \
      && mise plugin uninstall php && mise plugin install php https://github.com/asdf-community/asdf-php \
      && mise plugin uninstall rust && mise plugin install rust https://github.com/code-lever/asdf-rust \
      && mise plugin uninstall yarn && mise plugin install yarn https://github.com/mise-plugins/asdf-yarn

    mise install -y

    # setup rust
    rustup-init
  }

  main
)
