system_name := "orion"
dir := justfile_directory()

export NIX_CONFIG := "
  accept-flake-config = true
  extra-experimental-features = flakes nix-command
"

_default:
  @just --list

switch:
  @darwin-rebuild switch --flake "{{dir}}#{{system_name}}"

update:
  @nix flake update

gc:
  @nix-collect-garbage --delete-older-than 7d

fetch:
  @nix shell nixpkgs\#onefetch nixpkgs\#scc -c sh -c "onefetch --true-color never --no-bots -d lines-of-code && scc --no-cocomo ."

format:
  @alejandra "{{dir}}"

lint:
  @deadnix -e
