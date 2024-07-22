default:
  just --list

home *args:
  home-manager switch --flake . |& nom

fetch:
  @./scripts/fetch.sh

check:
  nix flake check |& nom

[macos]
switch:
  darwin-rebuild switch --flake . |& nom

[linux]
switch:
  nixos-rebuild switch --flake . |& nom

[macos]
clean:
  sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations old
  nix-collect-garbage -d
  nix store optimise


