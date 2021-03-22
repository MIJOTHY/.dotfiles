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

dep: $(DARWIN_REBUILD)
	sudo launchctl stop org.nixos.nix-daemon
	sudo launchctl start org.nixos.nix-daemon
.PHONY: dep

# Initialisation
install: dep update 

gc:
	nix-collect-garbage -d
	sudo nix-collect-garbage -d
.PHONY:	gc
