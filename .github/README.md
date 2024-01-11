# x0ba's dotfiles

[![flake check status](https://img.shields.io/github/actions/workflow/status/x0ba/dotfiles/check.yml?label=flake%20check&logo=nixos&logoColor=%23fff&style=flat-square&color=f5c2e7)](https://github.com/x0ba/dotfiles/actions/workflows/check.yml)
[![GitHub stars](https://img.shields.io/github/stars/x0ba/dotfiles?style=flat-square&color=f5c2e7)](https://github.com/x0ba/dotfiles/stargazers)
[![commit activity](https://img.shields.io/github/commit-activity/w/x0ba/dotfiles?style=flat-square&label=commits&color=f5c2e7)](https://github.com/x0ba/dotfiles/commits)
[![MIT license](https://img.shields.io/github/license/x0ba/dotfiles?style=flat-square&color=f5c2e7)](https://github.com/x0ba/dotfiles/blob/main/LICENSE)

Welcome to my Nix dots.

## Software

- Terminal: [Wezterm](https://github.com/wez/wezterm) (Nightly build from [my nur](https://github.com/x0ba/nur))
- Font: [Monaspace](https://https://monaspace.githubnext.com/)
- Colorscheme: [Catppuccin](https://github.com/catppuccin/catppuccin)
- Shell: [zsh](https://www.zsh.org/)
- Editor: [Neovim](https://github.com/neovim/neovim) for smaller editing, and [VSCode](https://code.visualstudio.com/) for larger projects

## Notes for a new install

This flake technically has an impurity at its core, because it assumes that it will be stored in `~/.config/flake` and will create symlinks pointing there.
This is so I can edit some dotfiles (e.g. VSCode `settings.json`) in place and have programs hot reload them.

### macOS

#### Install the [Xcode Command Line Tools](https://developer.apple.com/download/all/)

```console
xcode-select --install
```

#### Install [Homebrew](https://brew.sh)

```console
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash
```

#### Exclude `/nix/` from Time Machine

```console
sudo tmutil addexclusion -v /nix
```

### Building the flake

```console
nix --experimental-features "nix-command flakes" develop # enter the devShell
just switch
```

I personally use [`nix-direnv`](https://github.com/nix-community/nix-direnv) to automatically enter this devShell on my machines.
