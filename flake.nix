{
  description = "a starry night";

  outputs = {
    flake-parts,
    self,
    ...
  } @ inputs: let
    inherit (import ./machines/lib.nix {inherit inputs overlays;}) mkSystems;
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
          host = "draco";
          system = "x86_64-linux";
          username = "daniel";
          isGraphical = true;
        }
        {
          host = "andromeda";
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
            editorconfig-checker.enable = true;
            luacheck.enable = true;
            nil.enable = true;
            shellcheck.enable = true;
            stylua.enable = true;
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
    extra-substituters = [
      "https://cache.garnix.io"
      "https://mic92.cachix.org"
      "https://x0ba.cachix.org"
      "https://nix-community.cachix.org"
      "https://pre-commit-hooks.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "mic92.cachix.org-1:gi8IhgiT3CYZnJsaW7fxznzTkMUOn1RY4GmXdT/nXYQ="
      "x0ba.cachix.org-1:a8ujXsFYp+yjUv9sDb6jwSqqJ5wmD+ojnMcbmAQljPA="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "pre-commit-hooks.cachix.org-1:Pkk3Panw5AW24TOv6kz3PvLhlH8puAsJTBbOPmBo7Rc="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/nur";
    caarlos0-nur = {
      url = "github:caarlos0/nur";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    x0ba-nur.url = "github:x0ba/nur";

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.flake-compat.follows = "";
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-database.url = "github:nix-community/nix-index-database";
    sops = {
      url = "github:Mic92/sops-nix/1c673ba1053ad3e421fe043702237497bda0c621";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs";
    };
    swayfx = {
      url = "github:willpower3309/swayfx";
      inputs.flake-compat.follows = "";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ghostty.url = "github:clo4/ghostty-hm-module";

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
}
