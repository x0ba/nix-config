{
  description = "NixOS/nix-darwin/home-manager configuration.";
  nixConfig.commit-lockfile-summary = "chore: bump flake.lock";

  outputs = inputs:
    inputs.parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "aarch64-darwin"
        "x86_64-linux"
      ];
      imports = [
        ./modules/parts
        ./overlays
        ./hosts
        ./users
      ];
    };

  inputs = {
    # Flake inputs
    darwin.url = "github:lnl7/nix-darwin";
    ghostty.url = "github:clo4/ghostty-hm-module";
    emacs.url = "github:nix-community/emacs-overlay";
    home.url = "github:nix-community/home-manager";
    nil.url = "github:oxalica/nil";
    nix-colors.url = "github:Misterio77/nix-colors";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    wezterm.url = "github:x0ba/wezterm?ref=flake-darwin-app-bundle&dir=nix";
    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    lix-module.url = "https://git.lix.systems/lix-project/nixos-module/archive/2.90.0-rc1.tar.gz";
    nixos-wsl.url = "github:nix-community/nixos-wsl";
    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";
    apple-fonts.url = "github:x0ba/apple-fonts-flake";
    nixpkgs-fmt.url = "github:nix-community/nixpkgs-fmt";
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    parts.url = "github:hercules-ci/flake-parts";
    nvim.url = "github:nix-community/neovim-nightly-overlay";
    statix.url = "github:nerdypepper/statix";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";

    # Nixpkgs branches
    master.url = "github:nixos/nixpkgs/master";
    stable.url = "github:nixos/nixpkgs/release-23.05";
    mu-rev.url = "github:nixos/nixpkgs/99298c3da07f53464bc1a24b4b7d0882f1acf060";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Default Nixpkgs for packages and modules
    nixpkgs.follows = "unstable";

    # Minimize duplicate instances of inputs
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    emacs.inputs.nixpkgs.follows = "nixpkgs";
    home.inputs.nixpkgs.follows = "nixpkgs";
    nvim.inputs.flake-parts.follows = "parts";
    lix-module.inputs.nixpkgs.follows = "nixpkgs";
    nix-vscode-extensions.inputs.nixpkgs.follows = "nixpkgs";
    apple-fonts.inputs.nixpkgs.follows = "nixpkgs";
    apple-fonts.inputs.flake-parts.follows = "parts";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    wezterm.inputs.nixpkgs.follows = "nixpkgs";
    nix-minecraft.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
    pre-commit-hooks.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs-f2k.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs-f2k.inputs.parts.follows = "parts";
    statix.inputs.nixpkgs.follows = "nixpkgs";
  };
}
