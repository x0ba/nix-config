{
  description = "i have no idea what the fuck i'm doing.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-database.url = "github:Mic92/nix-index-database";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs-stable.follows = "nixpkgs";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    nix-colors.url = "github:misterio77/nix-colors";

    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-utils.url = "github:numtide/flake-utils";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";

    nur.url = "github:nix-community/NUR";
    nekowinston-nur.url = "github:nekowinston/nur";

    nixos-apple-silicon = {
      url = "github:tpwrules/nixos-apple-silicon";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.rust-overlay.follows = "rust-overlay";
    };

    rust-overlay.url = "github:oxalica/rust-overlay";

    # Non Flakes
    fzf-tab = {
      url = "github:Aloxaf/fzf-tab";
      flake = false;
    };

    sfmonoNerdFontLig = {
      url = "github:shaunsingh/SFMono-Nerd-Font-Ligaturized";
      flake = false;
    };

    zsh-completions = {
      url = "github:zsh-users/zsh-completions";
      flake = false;
    };

    zsh-nix-shell = {
      url = "github:chisui/zsh-nix-shell";
      flake = false;
    };

    zsh-syntax-highlighting = {
      url = "github:zsh-users/zsh-syntax-highlighting";
      flake = false;
    };

    zsh-autosuggestions = {
      url = "github:zsh-users/zsh-autosuggestions";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    home,
    darwin,
    ...
  } @ inputs: let
    inherit (self) outputs;
    forAllSystems = nixpkgs.lib.genAttrs [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
  in rec {
    # Your custom packages
    # Acessible through 'nix build', 'nix shell', etc
    packages = forAllSystems (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        import ./pkgs {inherit pkgs;}
    );
    # Devshell for bootstrapping
    # Acessible through 'nix develop' or 'nix-shell' (legacy)
    devShells = forAllSystems (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        import ./shell.nix {inherit pkgs;}
    );

    # Your custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};

    # Reusable nixos modules you might want to export
    # These are usually stuff you would upstream into nixpkgs
    nixosModules = import ./modules/nixos;
    # Reusable home-manager modules you might want to export
    # These are usually stuff you would upstream into home-manager
    homeManagerModules = import ./modules/home-manager;
    # Reusable darwin modules you might want to export
    # These are usually stuff you would upstream into darwin
    darwinModules = import ./modules/darwin;

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      starfall = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/starfall/configuration.nix
        ];
      };
    };
    darwinConfigurations = {
      "nebula" = darwin.lib.darwinSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/nebula/configuration.nix
        ];
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      "aspect@starfall" = home.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {
          inherit inputs outputs;
          flakePath = "/etc/nixos";
        };
        modules = [
          ./home/aspect/home.nix
        ];
      };
      "daniel@nebula" = home.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {
          inherit inputs outputs;
          flakePath = "/Users/daniel/.config/nixpkgs";
        };
        modules = [
          ./home/daniel/home.nix
        ];
      };
    };
    pre-commit = {
      check.enable = true;
      settings.hooks = {
        alejandra.enable = true;
        commitizen.enable = true;
        editorconfig-checker.enable = true;
        luacheck.enable = true;
        nil.enable = true;
        shellcheck.enable = true;
        stylua.enable = true;
      };
    };
  };
  nixConfig = {
    commit-lockfile-summary = "flake: bump inputs";
    substituters = [
      "https://cache.nixos.org"
      "https://mic92.cachix.org"
      "https://fortuneteller2k.cachix.org"
      "https://nix-community.cachix.org"
      "https://pre-commit-hooks.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "mic92.cachix.org-1:gi8IhgiT3CYZnJsaW7fxznzTkMUOn1RY4GmXdT/nXYQ="
      "fortuneteller2k.cachix.org-1:kXXNkMV5yheEQwT0I4XYh1MaCSz+qg72k8XAi2PthJI="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "pre-commit-hooks.cachix.org-1:Pkk3Panw5AW24TOv6kz3PvLhlH8puAsJTBbOPmBo7Rc="
    ];
  };
}
