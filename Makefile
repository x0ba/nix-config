# Shortcuts for building and applying this flake.
#   make switch   apply the config to this machine
#   make test     NixOS only: apply without making it the boot default
#   make check    evaluate every machine without building anything
#   make update   bump flake.lock
#   make fmt      format all .nix files

UNAME := $(shell uname)

ifeq ($(UNAME),Darwin)
NIXNAME ?= Daniels-MacBook-Pro-3
else
NIXNAME ?= nixos
endif

.PHONY: switch test check update fmt

switch:
ifeq ($(UNAME),Darwin)
	# Build first, then run darwin-rebuild from the result, so this also
	# works on a fresh Mac where darwin-rebuild isn't installed yet.
	nix build ".#darwinConfigurations.$(NIXNAME).system"
	sudo ./result/sw/bin/darwin-rebuild switch --flake ".#$(NIXNAME)"
else
	sudo nixos-rebuild switch --flake ".#$(NIXNAME)"
endif

test:
ifeq ($(UNAME),Darwin)
	@echo "darwin-rebuild has no 'test' mode; use 'make check' or 'make switch'." && exit 1
else
	sudo nixos-rebuild test --flake ".#$(NIXNAME)"
endif

check:
	nix flake check --all-systems --no-build
	nix eval --raw '.#darwinConfigurations.Daniels-MacBook-Pro-3.config.system.build.toplevel.drvPath' >/dev/null
	nix eval --raw '.#nixosConfigurations.nixos.config.system.build.toplevel.drvPath' >/dev/null
	@echo "All configurations evaluate."

update:
	nix flake update

fmt:
	nix fmt .
