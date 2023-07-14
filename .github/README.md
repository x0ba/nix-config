# aspect's dotfiles

[![NixOS Unstable](https://img.shields.io/badge/NixOS-unstable-blue.svg?style=flat-square&logo=NixOS&logoColor=white)](https://nixos.org)
[![commit activity](https://img.shields.io/github/commit-activity/w/aspectsides/dotfiles?style=flat-square&label=commits&color=f5c2e7)](https://github.com/aspectsides/dotfiles/commits)
[![SLOC](https://img.shields.io/tokei/lines/github/aspectsides/dotfiles)](#)
[![MIT license](https://img.shields.io/github/license/aspectsides/dotfiles?style=flat-square&color=f5c2e7)](https://github.com/aspectsides/dotfiles/blob/main/LICENSE)

*Here we go again.*

> **DISCLAIMER:** these are my personal nix dotfiles, and as such 
> might not work out of the box on your machine. If you want to 
> take inspiration from my dots, feel free, just copy chunks instead
> of the whole thing.
 
<img src="/../screenshots/oxocarbon/fakebusy.png" width="100%" />

<p align="center">
<span><img src="/../screenshots/oxocarbon/desktop.png" height="178" /></span>
<span><img src="/../screenshots/oxocarbon/jetbrains_supremacy.png" height="178" /></span>
<span><img src="/../screenshots/oxocarbon/tiling.png" height="178" /></span>
</p>

------

|                |                                                          |
|----------------|----------------------------------------------------------|
| **Shell:**     | zsh                                                      |
| **WM:**        | **sway** on linux, **yabai** on macos                    |
| **Editor:**    | Neovim                                                   |
| **Terminal:**  | kitty                                                    |
| **Launcher:**  | **rofi** on linux, **alfred** on macos                   |
| **Browser:**   | firefox                                                  |

-----

### Quick Start

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
./result/sw/bin/darwin-rebuild switch --flake .#nebula
```
