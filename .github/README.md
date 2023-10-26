# x0ba's dotfiles

[![flake check status](https://img.shields.io/github/actions/workflow/status/x0ba/dotfiles/check.yml?label=flake%20check&logo=nixos&logoColor=%23fff&style=flat-square&color=f5c2e7)](https://github.com/x0ba/dotfiles/actions/workflows/check.yml)
[![GitHub stars](https://img.shields.io/github/stars/x0ba/dotfiles?style=flat-square&color=f5c2e7)](https://github.com/x0ba/dotfiles/stargazers)
[![commit activity](https://img.shields.io/github/commit-activity/w/x0ba/dotfiles?style=flat-square&label=commits&color=f5c2e7)](https://github.com/x0ba/dotfiles/commits)
[![SLOC](https://img.shields.io/tokei/lines/github/x0ba/dotfiles?style=flat-square&color=f5c2e7)](#)
[![MIT license](https://img.shields.io/github/license/x0ba/dotfiles?style=flat-square&color=f5c2e7)](https://github.com/x0ba/dotfiles/blob/main/LICENSE)

Welcome to my Nix dots.

## Overview

Here's what you can find:

- **[WezTerm](https://wezfurlong.org/wezterm/)** as my terminal, with tmux-like keybindings
- **[Neovim](https://neovim.io)** as my tui editor & my JetBrains IdeaVim config
- **[Taskwarrior](https://taskwarrior.org)** for task management
- **[Starship](https://starship.rs)** as my prompt
- **Firefox** with privacy-centered settings
- Other random bits of config tools I've collected over the years
- The **[Oxocarbon](https://github.com/nyoom-engineering/oxocarbon.nvim)** theme, wherever possible
- macOS:
  - **[Yabai](https://github.com/koekeishiya/yabai)** as my WM
- Linux:
  - **[sway](https://swaywm.org)** as my WM

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
nix build .#darwinConfigurations.orion.system
./result/sw/bin/darwin-rebuild switch --flake .
```
