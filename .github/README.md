# aspect's dotfiles

[![GitHub stars](https://img.shields.io/github/stars/aspectsides/dotfiles?style=flat-square&color=f5c2e7)](https://github.com/aspectsides/dotfiles/stargazers)
[![commit activity](https://img.shields.io/github/commit-activity/w/aspectsides/dotfiles?style=flat-square&label=commits&color=f5c2e7)](https://github.com/aspectsides/dotfiles/commits)
[![SLOC](https://img.shields.io/tokei/lines/github/aspectsides/dotfiles?style=flat-square&color=f5c2e7)](#)
[![MIT license](https://img.shields.io/github/license/aspectsides/dotfiles?style=flat-square&color=f5c2e7)](https://github.com/nekowinston/dotfiles/blob/main/LICENSE)

Welcome to my cross-platform dots.
These include dots for an M1 Mac with Nix Darwin and an HP Laptop running NixOS

### Overview

Here's what you can find:

- **[Kitty](https://wezfurlong.org/wezterm/)** as my terminal, with tmux-like keybindings
- **[Neovim](https://neovim.io)** as my tui editor
- **[Taskwarrior](https://taskwarrior.org)** for task management
- **[Starship](https://starship.rs)** as my prompt
- **Firefox** with privacy-centered settings
- Other random bits of config tools I've collected over the years
- macOS:
  - **[Yabai](https://github.com/koekeishiya/yabai)** as my WM
- Linux:
  - **[awesome](https://swaywm.org)** as my WM

### Notes for a new install

#### macOS

##### Install the [Xcode Command Line Tools](https://developer.apple.com/download/all/)

```sh
xcode-select --install
```

##### [Install Brew](https://brew.sh)

```sh
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash
```

##### Exclude `/nix/` from Time Machine:

```sh
sudo tmutil addexclusion -v /nix
```

##### Initial build for the flake

```sh
nix build .#darwinConfigurations.nebula.system --extra-experimental-features nix-command --extra-experimental-features flakes
./result/sw/bin/darwin-rebuild switch --flake .
```
