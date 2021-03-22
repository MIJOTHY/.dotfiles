
#DEPRECATED, just have to migrate brew
# https://github.com/martinbaillie/dotfiles/blob/master/Makefile
# https://github.com/hlissner/dotfiles/blob/master/Makefile

SHELL 		:= bash
.SHELLFLAGS 	:= -euo pipefail -c
.ONESHELL: ;
.EXPORT_ALL_VARIABLES: ;
.DEFAULT_GOAL := switch

# Gets the dirname of this makefile
WORKDIR 	:=$(patsubst %/,%,$(dir $(realpath $(lastword $(MAKEFILE_LIST)))))
HOSTNAME	:=$(shell hostname -s)
MY_ENTRYPOINT   :=$(WORKDIR)/hosts/$(HOSTNAME)

# Dependency for rebuilding nix-darwin
DARWIN_REBUILD ?=$(if $(shell which darwin-rebuild 2>/dev/null),\
	$(shell which darwin-rebuild),/run/current-system/sw/bin/darwin-rebuild)
$(DARWIN_REBUILD): URL=https://github.com/LnL7/nix-darwin/archive/master.tar.gz
$(DARWIN_REBUILD):
	nix-build $(URL) -A installer
	yes | ./result/bin/darwin-installer

BREW ?=$(if $(shell which brew 2>/dev/null),\
	$(shell which brew),/usr/local/bin/brew)
$(BREW): URL=https://raw.githubusercontent.com/Homebrew/install/master/install
$(BREW): ; ruby -e "$$(curl -fsSL $(URL))"

dep: $(DARWIN_REBUILD) $(BREW)
	sudo launchctl stop org.nixos.nix-daemon
	sudo launchctl start org.nixos.nix-daemon
.PHONY: dep

# Initialisation
install: dep update 

# Updating
update: 
	$(BREW) update --quiet

gc:
	$(BREW) bundle cleanup --zap -f
	nix-collect-garbage -d
	sudo nix-collect-garbage -d
.PHONY:	gc
