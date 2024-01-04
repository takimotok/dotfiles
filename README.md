<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#prerequisites">Prerequisites</a></li>
    <li><a href="#installation">Installation</a></li>
  </ol>
</details>

## Prerequisites

- macOS
- create the directory as below due to be set `ghq root` as `/Users/${USER}/projects` in `.gitconfig`

```sh
# create the ~/projects directory
$ mkdir -p ~/projects/github.com/takimotok
```

## Installation

Run `install.sh` by curl:

```sh
$ cd ~/projects/github.com/takimotok

$ curl \
  -L https://github.com/takimotok/dotfiles/archive/refs/heads/main.tar.gz \
  -o dotfiles.tar.gz

$ tar xvf dotfiles.tar.gz

$ mv dotfiles-main dotfiles

$ rm -rf dotfiles.tar.gz

$ cd ./dotfiles

$ chmod u+x install.sh

$ ./install.sh
```

Alternatively run the commands below:

```sh
$ git clone https://github.com/takimotok/dotfiles.git
$ chmod u+x install.sh
$ ./install.sh
```

After that, we might need to reboot and/or restart.

In addition, the command below enable us to install some programming languages thanks to [jdx/mise: dev tools, env vars, task
runner](https://github.com/jdx/mise).

```sh
$ mise install -y
```

Then, we can search installed repositories with `^]` key.
