# Migration record

Source machine: Daniel's MacBook Pro, Apple Silicon, macOS 27.0. Inventory captured September 14, 2026.

## Backups

Private originals and package manifests are outside this Git repository:

`~/nix-migration-backup/20260914-181650/`

Home Manager also saves conflicting files with `.before-nix`. Application data, credentials, SSH/GPG keys, shell history, virtual machines, and project source are retained outside the Nix store.

## Coverage

| Previous installation/configuration | Declarative replacement |
| --- | --- |
| Homebrew-installed command line tools | Home Manager packages/program modules on unstable |
| Standalone Atuin, Starship, uv, fx, skl, agent CLIs | Nix packages; custom hash-pinned skl release |
| Hand-installed Prezto, shell scripts and hooks | Home Manager's native Zsh plugin/module options, Bash/Fish modules, program integrations |
| Shell prompt and file navigation | Starship, eza, bat, fzf, zoxide, yazi modules |
| Git, Jujutsu, GitHub CLI, Delta | Native Home Manager modules, existing identity and signing key |
| Homebrew GPG agent/pinentry path | Home Manager agent configuration, GnuPG autostart, Nix pinentry-mac |
| LazyVim's downloaded plugins and Mason | Nix-provided plugins/parsers; tools supplied by project devshells |
| Ghostty, Zed, Cursor, OpenCode | Native Home Manager modules; native macOS apps from casks |
| Cursor extensions | All four extensions installed by Home Manager; Anysphere VSIX files hash-pinned |
| Karabiner device mapping, herdr settings | Structured JSON/TOML generation |
| Zellij keybindings | Zellij module, preserving the existing KDL keymap |
| Desktop, Dock, Finder, trackpad, clock, Rectangle, Mos | nix-darwin preference modules |
| Homebrew itself and taps | nix-homebrew, auto-adopting the existing Apple Silicon prefix |
| Existing Homebrew apps and fonts | Declarative casks; four font families moved to Nix |
| Manually installed supported apps | Homebrew adoption of ChatGPT, Contexts, Mimestream, Raycast, Parallels, Roblox, Grok Bot, T3 Code Nightly |
| App Store apps | Declarative App Store IDs for 1Password for Safari, Outlook, Xcode |
| mise global dotfile tracking | Removed in favor of this repository and Home Manager |
| SDKMAN, rustup, mise-installed cloud tools, global Node/pnpm | Project-local Nix shells |

## Project shells

Added `.nix/` and `.envrc` locally in:

- `x0ba/tritonwatch`: Java 25, AWS CLI/session manager, Terraform, Node 24, pnpm 11.
- `x0ba/skl`: Rust/cargo/clippy/rustfmt/rust-analyzer, pkg-config, Node 24, pnpm 11.
- `x0ba/one-thing`, `x0ba/love`, `x0ba/peek`, `x0ba/bud`: Node 24 and pnpm 11.
- `x0ba/grok-bot-marketplace`: Node 24/npm.
- `atem3d/upwordly`: Node 24 and Bun.

These are project files outside this configuration repository; review and commit them in their respective repositories. Their locks are independent of future workstation updates. Existing flakes in `site`, `noscam`, and `ieeeatucsd-org` remain authoritative.

Project package dependencies continue to be installed by their project package manager. The workstation does not install project dependencies globally. Existing private runtime data such as Terraform state and cloud credentials is preserved.

## Exceptions and limitations

- macOS rejects nix-darwin's PAM include link on this installation. `security.pam.services.sudo_local.enable = false` leaves native authentication in place.
- GnuPG starts its agent on demand. The Home Manager agent module manages its settings and pinentry, with its incompatible macOS launchd service disabled.
- Determinate Nix, macOS/Xcode-provided tools, OS services, system extensions, and Apple-managed settings remain under their existing system owners.
- Browser profiles, app accounts/licenses, secrets, application databases, agent conversation/plugin/trust state, and local VM data are mutable application data. They are not copied into the public-readable Nix store.
- Codex's desktop-generated MCP/runtime/plugin/trust configuration remains app-owned: it contains build-specific paths and changes while the app runs. Its CLI package is managed by Nix.
- Bespoke/sideloaded applications (Delta, Fastpotify, FlowrWisp, Gridka, Hilium, Railway Monitor, Studio by Spotify Labs), Supercharge, VMware Fusion, and individual Adobe-suite installs have no adopted package definition here. Their data and existing bundles are retained for later handling; they are not reproduced by this flake.
- The App Store installation request for Things 3 was canceled. Its existing app is retained, and its ID is excluded from activation.
- Spotify/Spicetify modifications are outside the declarative application configuration. The standard Spotify cask is managed.
- Homebrew casks and App Store apps are declared by package identity. Already-installed versions are retained on activation (`upgrade = false`); upstream auto-updaters and App Store distribution are not bit-for-bit Nix builds. Explicitly upgrade apps when desired.
- New projects need their own devshell and a one-time `direnv allow`. No global trust or automatic approval of arbitrary `.envrc` files is configured.

## Validation

The system derivation builds on this Mac; flake evaluation and formatting checks pass. Home Manager activation passes. LazyVim starts with Nix-provided plugins, no missing active plugins, and private Lua/shell editing helpers. Ghostty accepts its generated configuration. Fresh Zsh and Fish shells use the Nix packages and load nix-direnv. Atuin reports a healthy daemon; GnuPG can access the existing keyring and starts its Nix agent on demand. Signing with the protected key still requires the normal passphrase prompt.

All eight new project devshells and all three pre-existing shells load successfully through direnv. The Java/AWS/Terraform and Rust shells run their tool version checks successfully. UpWordly's typecheck passes; its mutating `bun check` passes in a scratch copy to avoid reformatting unrelated project files.

The initial system activation completed successfully. Homebrew now has 55 casks and zero formula installations. The 48 superseded user installation/configuration paths are archived under `retired/`; the old standalone Starship binary and broken Homebrew completion link are archived separately. Spicetify was restored before retirement. Final activation status is recorded in the private backup directory logs and the completion report.

## References

- [nix-darwin setup](https://github.com/nix-darwin/nix-darwin)
- [Home Manager nix-darwin integration](https://nix-community.github.io/home-manager/nix-flakes/nix-darwin.html)
- [nix-homebrew adoption and declarative taps](https://github.com/zhaofengli/nix-homebrew)
- [GnuPG agent autostart](https://www.gnupg.org/documentation/manuals/gnupg/Invoking-GPG_002dAGENT.html)
