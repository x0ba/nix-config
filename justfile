# Shortcuts for building and applying this flake.
#   just switch   apply the config to this machine
#   just test     NixOS only: apply without making it the boot default
#   just check    evaluate every machine without building anything
#   just update   bump flake.lock
#   just fmt      format all .nix files

nixname := env("NIXNAME", if os() == "macos" { "Daniels-MacBook-Pro" } else { "nixos" })

# List recipes
default:
    @just --list

# Apply the config to this machine
[macos]
switch:
    # Build first, then run darwin-rebuild from the result, so this also
    # works on a fresh Mac where darwin-rebuild isn't installed yet.
    nix build ".#darwinConfigurations.{{nixname}}.system"
    sudo ./result/sw/bin/darwin-rebuild switch --flake ".#{{nixname}}"

# Apply the config to this machine
[linux]
switch:
    sudo nixos-rebuild switch --flake ".#{{nixname}}"

# NixOS only: apply without making it the boot default
[macos]
test:
    @echo "darwin-rebuild has no 'test' mode; use 'just check' or 'just switch'." && exit 1

# NixOS only: apply without making it the boot default
[linux]
test:
    sudo nixos-rebuild test --flake ".#{{nixname}}"

# Evaluate every machine without building anything
check:
    nix flake check --all-systems --no-build
    nix eval --raw '.#darwinConfigurations.Daniels-MacBook-Pro.config.system.build.toplevel.drvPath' >/dev/null
    nix eval --raw '.#nixosConfigurations.nixos.config.system.build.toplevel.drvPath' >/dev/null
    @echo "All configurations evaluate."

# Bump flake.lock
update:
    nix flake update

# Format all .nix files
fmt:
    nix fmt .
