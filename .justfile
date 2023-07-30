default:
  @just --choose
switch:
  darwin-rebuild switch --flake .#nebula --show-trace
hm:
  home-manager switch --flake .#daniel@nebula --show-trace
delete-old:
  sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations old && nix run home-manager#home-manager -- expire-generations now 
gc:
  nix store gc
