# Author: takimotok <example@gmail.com>
# Description: logging functions.

# variables
# -----
DOTPATH := $(CURDIR)
DOTS := $(wildcard .??*)
CONFIG := $(wildcard .config/*)
# list dotfiles under the current dir. and the .config dir.
TARGET := $(DOTS) $(CONFIG)
EXCLUSIONS := .DS_Store .git .gitignore .config
DOTFILES := $(filter-out $(EXCLUSIONS), $(TARGET))
# ZSHFILES := .zsh.d .zshrc .zshenv

# define to do nothing in case `make` commands run w/o any arguments
.PHONY: all
all: ;

.PHONY: init
init:
	@echo "==> Initializing..."
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/init/init.sh

deploy:
	@echo '==> Deploying... Copying dotfiles to home directory.'
	@echo ''
	@$(foreach val,$(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)
#

# debug
debug:
	@echo "==> Debugging..."
	@echo "DOTFILES = "
	bash $(DOTPATH)/etc/init/init.sh

