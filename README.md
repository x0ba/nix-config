[![built with nix](https://img.shields.io/static/v1?logo=nixos&logoColor=white&label=&message=Built%20with%20Nix&color=41439a)](https://builtwithnix.org)

# My NixOS configurations

Here's my NixOS/Nix-Darwin/home-manager config files. Requires [Nix flakes](https://nixos.wiki/wiki/Flakes).

**Highlights**:

- Multiple **NixOS configurations**, including **laptop** and **MacBook**
- **Secrets** using **sops-nix**
- Flexible **Home Manager** Configs through **feature flags**
- Extensively configured wayland environments (**sway** and **hyprland**) and editor (**neovim**)
- **Declarative** **themes** and with **nix-colors**

## Structure

- `flake.nix`: Entrypoint for hosts and home configurations. Also exposes a
  devshell for boostrapping (`nix develop` or `nix-shell`).
- `hosts`: NixOS Configurations, accessible via `nixos-rebuild --flake`.
  - `shared`: Shared configurations consumed by the machine-specific ones.
    - `nixos`: Configurations that are globally applied to all NixOS machines.
    - `darwin`: Configurations that are globally applied to all my Mac machines.
  - `orion`: MacBook Air M1, 8 GB RAM | Daily Driver laptop
  - `starfall`: Same laptop running Asahi NixOS
- `home`: My Home-manager configuration, acessible via `home-manager --flake`
    - Each directory here is a "feature" each hm configuration can toggle, thus
      customizing my setup for each machine (be it a server, desktop, laptop,
      anything really).
- `modules`: A few actual modules (with options) I haven't upstreamed yet.
- `overlay`: Patches and version overrides for some packages. Accessible via
  `nix build`.
- `pkgs`: My custom packages. Also accessible via `nix build`. You can compose
  these into your own configuration by using my flake's overlay, or consume them through NUR.


## How to bootstrap

All you need is nix (any version). Run:
```
nix-shell
```

If you already have nix 2.4+, git, and have already enabled `flakes` and
`nix-command`, you can also use the non-legacy command:
```
nix develop
```

`nixos-rebuild --flake .` or `darwin-rebuild --flake .` To build system configurations

`home-manager --flake .` To build user configurations

`nix build` (or shell or run) To build and use packages

`sops` To manage secrets


## Secrets

For deployment secrets (such as user passwords and server service secrets), I'm
using the awesome [`sops-nix`](https://github.com/Mic92/sops-nix). All secrets
are encrypted with my personal PGP key.

## Tooling and applications I use

Most relevant user apps daily drivers:

- yabai
- sketchybar
- neovim
- zsh + powerlevel10k
- wezterm
- orion
- aerc
- gpg
- zathura
- raycast
- bat + fd + rg

Nixy stuff:

- nix-colors
- sops-nix
- home-manager
- and NixOS and nix itself, of course :)

Let me know if you have any questions about them :)

## Unixpornish stuff
![fakebusy](https://i.imgur.com/vjU1E8l.png)
![clean](https://i.imgur.com/WlkhmkX.jpg)

That's how my macos desktop setup look like (as of 2023 August).


