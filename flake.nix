{
  description = "can you hear the music?";

  inputs = {
    # All packages should follow nixpkgs-unstable
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # nix darwin for macos system configuration
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # home-manager for dotfile/user management
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

    # vscode extensions for home manager
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.flake-compat.follows = "";
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # agenix
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # my neovim config
    neovim.url = "github:x0ba/neovim.drv";

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
    flake-parts.lib.mkFlake {inherit self inputs;} {
      flake = mkSystems [
        {
          host = "fermata";
          system = "aarch64-darwin";
          username = "daniel";
          extraModules = [inputs.x0ba-nur.darwinModules.default];
          isGraphical = true;
        }
        {
          host = "scherzo";
          system = "x86_64-linux";
          username = "daniel";
          isGraphical = true;
        }
        {
          host = "fugue";
          system = "x86_64-linux";
          username = "daniel";
          isGraphical = true;
        }
      ];
      imports = [inputs.pre-commit-hooks.flakeModule];
      perSystem = {
        config,
        self',
        inputs',
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
            shellcheck.enable = true;
          };
        };

        devShells.default = pkgs.mkShell {
          inherit (config.pre-commit.devShell) shellHook;
          RULES = "./home/secrets/secrets.nix";
          buildInputs = with pkgs;
            [
              alejandra
              git-crypt
              age-plugin-yubikey
              just
              nil
              nix-output-monitor
              nvd
              inputs'.agenix.packages.agenix
            ]
            ++ lib.optionals stdenv.isDarwin
            [inputs'.darwin.packages.darwin-rebuild];
        };

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
    extra-substituters = [
      "https://cache.garnix.io"
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      "https://numtide.cachix.org"
      "https://x0ba.cachix.org"
      "https://pre-commit-hooks.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
      "x0ba.cachix.org-1:+WLqIY3Ygu/++D57/ZeUSO9jbDwnhQ6vzCXtaghpn9E="
      "pre-commit-hooks.cachix.org-1:Pkk3Panw5AW24TOv6kz3PvLhlH8puAsJTBbOPmBo7Rc="
    ];
  };
}
