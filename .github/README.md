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

## Frequently asked questions

+ **Why NixOS?**

  Because I was bored and now I can't go back to the mess of dependency
  hell and frequent breakage that was Arch.
  
+ **Should I use NixOS?**

  **Short answer:** no.
  
  **Long answer:** no really. Don't.
  
  **Long long answer:** I'm not kidding. Don't.
  
  **Unsigned long long answer:** Alright alright. Here's why not:

  - Its learning curve is steep.
  - You _will_ trial and error your way to enlightenment, if you survive long
    enough.
  - NixOS is unlike other Linux distros. Your issues will be unique and
    difficult to google.
  - If the words "declarative", "generational", and "immutable" don't make you
    _fully_ erect, you're considering NixOS for the wrong reasons.
  - The overhead of managing a NixOS config will rarely pay for itself with
    fewer than 3 systems (perhaps another distro with nix on top would suit you
    better?).
  - Official documentation for Nix(OS) is vast, but shallow.
  - Unofficial resources and example configs are sparse and tend to be either
    too simple or too complex (or outdated).
  - The Nix language is obtuse and its toolchain is unintuitive. This is made
    infinitely worse if you've never touched the shell or a functional language
    before, but you'll _need_ to learn it to do even a fraction of what makes
    NixOS worth all the trouble.
  - A decent grasp of Linux and its ecosystem is a must, if only to distinguish
    Nix(OS) issues from Linux (or upstream) issues -- as well as to debug them
    or report them to the correct authority (and coherently).
  - If you need somebody else to tell you whether or not you need NixOS, you
    don't need NixOS.

  If none of this has deterred you, then you didn't need my advice in the first
  place. Stop procrastinating and try NixOS!
  
+ **How do you manage secrets?**

  With sops.nix.

  + A couple flake configs that I 
    [may](https://github.com/LEXUGE/nixos) 
    [have](https://github.com/bqv/nixrc)
    [shamelessly](https://git.sr.ht/~dunklecat/nixos-config/tree)
    [rummaged](https://github.com/utdemir/dotfiles)
    [through](https://github.com/purcell/dotfiles).
  + [Some notes about using Nix](https://github.com/justinwoo/nix-shorts)
  + [Learn from someone else's descent into madness; this journals his
    experience digging into the NixOS
    ecosystem](https://www.ianthehenry.com/posts/how-to-learn-nix/introduction/)
  + [What y'all will need when Nix drives you to drink.](https://www.youtube.com/watch?v=Eni9PPPPBpg)
