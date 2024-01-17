{
  description = "a starry night";

  inputs = {
    # All packages should follow nixpkgs-unstable
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Nix-darwin
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # HM-manager for dotfile/user management
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nurs
    nur.url = "github:nix-community/nur";
    caarlos0-nur = {
      url = "github:caarlos0/nur";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    x0ba-nur.url = "github:x0ba/nur";

    # installing vscode extensions with home-manager
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.flake-compat.follows = "";
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin-vsc = {
      url = "github:catppuccin/vscode";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # declarative color theming
    nix-colors.url = "github:Misterio77/nix-colors";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-database.url = "github:nix-community/nix-index-database";

    # flake utilities
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-utils.url = "github:numtide/flake-utils";
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.flake-compat.follows = "";
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs";
    };
  };

  outputs = {
    flake-parts,
    self,
    ...
  } @ inputs: let
    inherit (import ./hosts/lib.nix {inherit inputs overlays;}) mkSystems;
    overlays = import ./pkgs/overlays.nix {inherit inputs;};
  in
    flake-parts.lib.mkFlake {inherit self inputs;}
    {
      flake = mkSystems [
        {
          host = "orion";
          system = "aarch64-darwin";
          username = "daniel";
          extraModules = [inputs.x0ba-nur.darwinModules.default];
          isGraphical = true;
        }
        {
          host = "andromeda";
          system = "x86_64-linux";
          username = "daniel";
          isGraphical = true;
        }
        {
          host = "polaris";
          system = "x86_64-linux";
          username = "daniel";
          isGraphical = true;
        }
      ];
      imports = [inputs.pre-commit-hooks.flakeModule];
      perSystem = {
        config,
        pkgs,
        system,
        ...
      }: {
        _module.args.pkgs = import inputs.nixpkgs {
          inherit overlays system;
          config.allowUnfree = true;
        };

        pre-commit = {
          check.enable = true;
          settings.hooks = {
            alejandra.enable = true;
            commitizen.enable = true;
            nil.enable = true;
          };
        };

        devShells.default = config.pre-commit.devShell.overrideAttrs (_old: {
          buildInputs = with pkgs;
            [alejandra just nil nix-output-monitor nvd]
            ++ lib.optionals stdenv.isDarwin [inputs.darwin.packages.${system}.darwin-rebuild];
        });

        legacyPackages.homeConfigurations = let
          homeLib = import ./home/lib.nix {
            inherit inputs pkgs username;
            isNixOS = false;
          };
          username = "daniel";
        in {
          ${username} = inputs.home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            inherit (homeLib) extraSpecialArgs modules;
          };
        };

        formatter = pkgs.alejandra;
      };
      systems = ["aarch64-darwin" "aarch64-linux" "x86_64-darwin" "x86_64-linux"];
    };

  nixConfig = {
    extra-substituters = ["https://cachix.cachix.org" "https://nix-community.cachix.org" "https://x0ba.cachix.org"];
    extra-trusted-public-keys = [
      "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "x0ba.cachix.org-1:+WLqIY3Ygu/++D57/ZeUSO9jbDwnhQ6vzCXtaghpn9E="
    ];
  };
}
