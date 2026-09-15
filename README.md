# Daniel's Mac

Apple Silicon macOS configuration using nix-darwin, Home Manager, and nix-homebrew.

## Apply

```sh
nix build .#darwinConfigurations.Daniels-MacBook-Pro.system
sudo ./result/sw/bin/darwin-rebuild switch --flake .#Daniels-MacBook-Pro
```

Run activation in a terminal: some Homebrew casks and Mac App Store installations invoke sudo as the logged-in user.

## Update

```sh
nix flake update
nix build .#darwinConfigurations.Daniels-MacBook-Pro.system
sudo ./result/sw/bin/darwin-rebuild switch --flake .#Daniels-MacBook-Pro
```

`nixpkgs-unstable` is the default. `pkgs.stable` exposes the pinned `nixpkgs-26.05-darwin` fallback; currently no package needs it. The installed Determinate Nix distribution continues to manage its own daemon (`nix.enable = false`).

## Organization

- `darwin/configuration.nix`: machine, shells, fonts, Nix integration.
- `darwin/homebrew.nix`: declarative Homebrew installation, pinned taps, casks, App Store apps.
- `darwin/defaults.nix`: captured macOS preferences.
- `home-manager/`: shell integrations, Git/Jujutsu, signing agent, terminal and editor settings.
- `pkgs/`: pinned packages for skl and Cursor's Anysphere extensions.

Prefer a Home Manager program module when one exists. Extra files are limited to application formats or plugin source not represented by module options. LazyVim uses lazy.nvim for loading; Nix installs its plugins and Tree-sitter parsers. Mason and plugin downloads are disabled. Project language servers and formatters belong in devshells. The existing Lua/shell editing helpers are scoped to Neovim’s wrapper.

## Project dependencies

AWS, Terraform, Java, Rust, Node.js, pnpm, and Bun are **not installed globally**. Runtime dependencies privately used by packaged applications may still appear in their Nix store closures.

Home Manager installs `direnv` with `nix-direnv` and hooks Bash, Fish, and Zsh. A new project's `.envrc` needs `direnv allow` once. Existing approved environments load automatically when entering the directory and unload when leaving.

The migration added isolated `.nix/flake.nix` and `.nix/flake.lock` files to projects without devshells. Their `.envrc` uses `use flake "path:$PWD/.nix"`, so Nix imports only the toolchain definition, avoiding untracked project files and secrets. Projects that already had flakes keep their own definitions.

See [migration notes](docs/migration.md) for coverage, exceptions, and verification.
