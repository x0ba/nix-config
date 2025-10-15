# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Nix flake configuration repository for managing both macOS (via nix-darwin) and NixOS systems. It uses flakes, home-manager for user environment management, agenix for secrets management, and supports multiple system architectures.

## Commands

### Building and Switching (macOS)

```bash
# Build the configuration (without switching)
nix run .#build

# Build and switch to new generation
nix run .#build-switch

# Alternative: Direct darwin-rebuild
darwin-rebuild switch --flake .#aarch64-darwin  # or x86_64-darwin
```

### Building and Switching (NixOS)

```bash
# Build and switch
nix run .#build-switch

# Install system (fresh install)
nix run .#install
```

### Other Common Commands

```bash
# Enter development shell (includes git, age, nixfmt)
nix develop

# Apply configuration changes (interactive setup script)
nix run .#apply

# Clean old generations
nix run .#clean

# Rollback to previous generation (macOS only)
nix run .#rollback

# Format Nix files
nixfmt **/*.nix

# Check flake
nix flake check
```

### Secrets Management

```bash
# Create encryption keys
nix run .#create-keys

# Copy keys to remote
nix run .#copy-keys

# Verify keys
nix run .#check-keys
```

## Architecture

### Flake Structure

The repository follows a modular flake-based architecture with clear separation between Darwin (macOS) and NixOS configurations:

- **flake.nix**: Main entry point. Defines inputs (nixpkgs, home-manager, agenix, nix-darwin, disko, nix-index-database, secrets), outputs (darwinConfigurations, nixosConfigurations), and flake apps for common operations.
- **flake.lock**: Pinned versions of all inputs.

### Host Configurations

- **hosts/darwin/default.nix**: macOS-specific system configuration including nix-darwin settings, launchd services (Emacs daemon), Touch ID/Apple Watch sudo authentication, macOS defaults (keyboard, dock, finder, trackpad).
- **hosts/nixos/default.nix**: NixOS-specific system configuration including boot loader settings, X server with BSPWM window manager, Picom compositor with animations, Syncthing, Docker, hardware configuration.

### Modules Organization

The modules are organized into three categories representing shared and platform-specific code:

**modules/shared/**: Cross-platform configurations
- **default.nix**: Nixpkgs config (allowUnfree, overlays including emacs-overlay), applied to both Darwin and NixOS.
- **packages.nix**: Common packages across platforms (development tools, CLI utilities, security tools).
- **home-manager.nix**: Shared home-manager programs (zsh, git, vim, tmux, starship, direnv, ghostty, eza, zoxide, atuin, bat).
- **files.nix**: Dotfiles and config files.

**modules/darwin/**: macOS-specific configurations
- **home-manager.nix**: Darwin user setup, integrates shared + darwin-specific files and packages.
- **packages.nix**: macOS-specific packages (minimal, mostly deferred to shared).
- **brew.nix**: Homebrew casks (GUI applications like Arc, Claude, Notion, VSCode, etc.). Auto-updates and cleans up on activation.
- **files.nix**: Darwin-specific dotfiles.
- **secrets.nix**: Agenix secrets for macOS.

**modules/nixos/**: NixOS-specific configurations
- **home-manager.nix**: NixOS home-manager integration for user daniel.
- **packages.nix**: NixOS-specific packages.
- **disk-config.nix**: Disko disk partitioning configuration.
- **files.nix**: NixOS-specific files and configs.
- **secrets.nix**: Agenix secrets for NixOS.

### Key Integration Points

1. **Home-manager integration**: Both platforms use home-manager but initialize differently. Darwin uses `darwinModules.home-manager` while NixOS uses `nixosModules.home-manager`.

2. **Secrets management**: Uses agenix for encrypted secrets. Separate secrets.nix files for each platform reference a private secrets repository defined in flake inputs.

3. **Package organization**: Shared packages are in modules/shared/packages.nix and imported by both platforms. Platform-specific packages extend this base set.

4. **User configuration**: The user "daniel" is hardcoded in multiple places. Configuration is personalized with git name/email in modules/shared/home-manager.nix.

5. **Overlays**: Applied via modules/shared/default.nix. Automatically imports all *.nix files from overlays/ directory plus the emacs-overlay.

### Apps Scripts

Located in `apps/{architecture}/` directories, these are bash scripts for system management:
- **apply**: Interactive setup script that customizes the config with user details, GitHub secrets repo, hostname, etc.
- **build**: Build configuration without switching (Darwin only).
- **build-switch**: Build and switch to new generation.
- **clean**: Remove old generations.
- **create-keys**, **copy-keys**, **check-keys**: Agenix key management.
- **install**: Fresh system install (NixOS only).
- **rollback**: Revert to previous generation (Darwin only).

## Development Notes

- **System variable**: The primary user is "daniel", defined in host configurations.
- **Architecture support**: Flake supports aarch64-darwin, x86_64-darwin, aarch64-linux, x86_64-linux.
- **Experimental features**: Requires `nix-command` and `flakes` experimental features enabled.
- **State versions**: Darwin stateVersion is 5, NixOS is 21.05 (set in host configs).
- **Emacs daemon**: Runs as a launchd service on macOS, systemd service on NixOS (currently commented out).
- **nix-index-database**: Integrated for command-not-found functionality on both platforms.

## Important File Locations

- Shell configuration: modules/shared/home-manager.nix (zsh config)
- GUI applications (macOS): modules/darwin/brew.nix
- System defaults (macOS): hosts/darwin/default.nix
- Window manager (NixOS): hosts/nixos/default.nix (BSPWM + Picom)
- Overlays: overlays/ directory (auto-imported)
