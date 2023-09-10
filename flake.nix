{
  description = "A galactic nix flake.";

  inputs = {
    # Nix Channels
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    darwin.url = "github:lnl7/nix-darwin";

    # nix modules
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-colors.url = "github:misterio77/nix-colors";
    nix-index-database.url = "github:Mic92/nix-index-database";

    # overlays
    nur.url = "github:nix-community/NUR";
    nekowinston-nur.url = "github:nekowinston/nur";
    caarlos0-nur.url = "github:caarlos0/nur";
    rust-overlay.url = "github:oxalica/rust-overlay";
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # hardware
    nixos-apple-silicon = {
      url = "github:tpwrules/nixos-apple-silicon";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.rust-overlay.follows = "rust-overlay";
    };

    # follows
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , darwin
    , ...
    } @ inputs:
    let
      inherit (self) outputs;
      forAllSystems = nixpkgs.lib.genAttrs [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
    in
    rec {
      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        import ./pkgs { inherit pkgs; }
      );

      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        import ./shell.nix { inherit pkgs; }
      );

      overlays = import ./overlays { inherit inputs; };

      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;
      darwinModules = import ./modules/darwin;

      # daily driver macbook
      darwinConfigurations = {
        "orion" = darwin.lib.darwinSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./hosts/orion
          ];
        };
      };

      homeConfigurations = {
        "daniel@starfall" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-linux;
          extraSpecialArgs = {
            inherit inputs outputs;
            flakePath = "/etc/nixos";
          };
          modules = [
            ./home/daniel/starfall.nix
          ];
        };
        "daniel@orion" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          extraSpecialArgs = {
            inherit inputs outputs;
            flakePath = "/Users/daniel/.config/nixpkgs";
          };
          modules = [
            ./home/daniel/orion.nix
          ];
        };
      };
    };

  nixConfig = {
    extra-substituters = [
      "https://cache.garnix.io"
      "https://mic92.cachix.org"
      "https://nekowinston.cachix.org"
      "https://nix-community.cachix.org"
      "https://pre-commit-hooks.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "mic92.cachix.org-1:gi8IhgiT3CYZnJsaW7fxznzTkMUOn1RY4GmXdT/nXYQ="
      "nekowinston.cachix.org-1:lucpmaO+JwtoZj16HCO1p1fOv68s/RL1gumpVzRHRDs="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "pre-commit-hooks.cachix.org-1:Pkk3Panw5AW24TOv6kz3PvLhlH8puAsJTBbOPmBo7Rc="
    ];
  };
}
