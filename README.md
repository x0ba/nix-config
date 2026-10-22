# nix-config

One flake (flake-parts) for:

- `darwinConfigurations."Daniels-MacBook-Pro-3"`: nix-darwin + Home Manager
- `nixosConfigurations.nixos`: a basic NixOS box with the same user, shell and CLI tools

```
flake.nix               inputs + flake-parts setup
hosts/default.nix       builds both machines, plugs in Home Manager
hosts/darwin/           Mac system settings
hosts/nixos/            NixOS system (replace hardware-configuration.nix on the real machine)
modules/shared/nix.nix  Nix settings for both
modules/darwin/         Homebrew casks, macOS defaults
home/                   Home Manager: shared by both machines
home/darwin.nix         Mac-only bits (Ghostty, Zed, OrbStack)
home/config/            nvim + zed configs, linked in so the apps can still write to them
```

## First run on the Mac

1. Install Determinate Nix: `curl -fsSL https://install.determinate.systems/nix | sh -s -- install`
   (or the Determinate macOS installer package). nix-darwin is set to leave Nix itself alone.
2. Move the old dotfiles out of the way:
   ```sh
   mkdir ~/dotfiles-backup
   mv ~/.zshrc ~/.zshenv ~/.zprofile ~/.zlogin ~/.zlogout ~/.zpreztorc ~/dotfiles-backup/
   mv ~/.config/{nvim,ghostty,gh/config.yml,zed/settings.json} ~/dotfiles-backup/ 2>/dev/null
   ```
   Anything you miss gets renamed to `*.before-nix` instead of breaking the switch.
3. Apply:
   ```sh
   cd ~/nix-config
   sudo nix run nix-darwin -- switch --flake .
   ```
   After that: `sudo darwin-rebuild switch --flake ~/nix-config`.
4. Remove the Homebrew CLIs that Nix now provides:
   `brew uninstall btop coreutils fd fish fzf gh git htop hunk jj mackup neovim qpdf ripgrep yazi zoxide`
   Then set `homebrew.onActivation.cleanup = "uninstall"` if you want the cask list enforced.
5. Optional cleanup: `~/.zprezto`, `~/.atuin/bin`, `~/.local/bin/mise`, `~/.opencode` and
   `~/.local/bin/claude` (Nix provides all of these now; the old `~/.local/bin/claude` still wins on PATH while it exists).
   grok and vite-plus aren't part of this setup: `~/.grok`, `~/.local/bin/grok`,
   `~/.config/vite-plus` and `~/.local/share/vite-plus` can go too.

## NixOS

On the machine: copy this repo to `~/nix-config`, replace `hosts/nixos/hardware-configuration.nix`
with `nixos-generate-config --show-hardware-config`, check `nixpkgs.hostPlatform`, then
`sudo nixos-rebuild switch --flake ~/nix-config#nixos`.

## Updating

`nix flake update` then rebuild.
