<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#prerequisites">Prerequisites</a></li>
    <li><a href="#installation">Installation</a></li>
  </ol>
</details>

## Prerequisites

Almost all dotfiles are resides in `~/.config` directory.

- macOS
- set `ZDOTDIR` environment variable to use `zsh` under the XDG Base Directory specification

```sh
# set ZDOTDIR to use XDG Base Directories
$ echo "export ZDOTDIR=$HOME/.config/zsh" | sudo tee -a /etc/zshenv
```

## Installation

Run `install.sh` by curl:

```sh
$ mkdir -p ~/.config && \
  mkdir -p ~/projects/github.com/takimotok

$ cd ~/projects/github.com/takimotok

$ curl \
  -L https://github.com/takimotok/dotfiles/archive/refs/heads/main.tar.gz \
  -o dotfiles.tar.gz

$ tar xvf dotfiles.tar.gz

$ mv dotfiles-main dotfiles
$ rm -rf dotfiles.tar.gz

$ cd ./dotfiles
$ chmod u+x install.sh
$ chmod -R u+x ./src
$ ./install.sh
```

Alternatively run the commands below:

```sh
$ git clone https://github.com/takimotok/dotfiles.git
$ chmod u+x install.sh
$ chmod -R u+x ./src
$ ./install.sh
```

After that, we might need to reboot and/or restart.

In addition, the commands below enable us to install some programming languages thanks to [jdx/mise: dev tools, env vars, task runner](https://github.com/jdx/mise).

```sh
$ mise install -y

# check
$ mise ls

# e.g.) use Python 3.11 as global
$ mise use --global python@3.11
```

Then, we can search installed repositories with `^]` key.

## Setup rust

cf.) `packages/mise/install.sh`

```sh
# setup rust
# select `1` below
$ rustup-init

...
1) Proceed with installation (default)
2) Customize installation
3) Cancel installation
...

```

## Setup zed

The files below should be linked into `~/.config/zed/{here}`.

- keymap.json
- settings.json

```sh
$ pwd
/path/to/dotfiles

$ mkdir -p $HOME/.config/zed/

$ ln -sf $PWD/.config/zed/keymap.json $HOME/.config/zed/keymap.json

$ ln -sf $PWD/.config/zed/settings.json $HOME/.config/zed/settings.json
```

We can find the installed extensions location like:

```sh
$ ls ~/Library/Application\ Support/Zed/extensions/installed/

```

cf.) [Configuring Zed - Zed](https://zed.dev/docs/configuring-zed#auto-install-extensions)

## Setup Cursor

See `.config/cursor/extensions.txt` and then run the command below:

```sh
$ cursor --install-extension "extension name here"

```

## Firefox data migration

I followed the instruction below but no luck.  
Alternatively, I just copied whole of `Firefox` folder to another machine and it works.

cf)

- [Back up and restore information in Firefox profiles | Firefox Help](https://support.mozilla.org/en-US/kb/back-and-restore-information-firefox-profiles)
