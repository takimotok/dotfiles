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
- create the `~/projects` directory due to be set `ghq root` as `/Users/${USER}/projects` in `.gitconfig`

```sh
# create the ~/projects directory
$ mkdir -p ~/projects
```

## Installation

Run `install.sh` by curl:

```sh
$ curl -L raw.githubusercontent.com/takimotok/dotfiles/main/install.sh | bash
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
