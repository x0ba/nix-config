{
  description = "x0ba's nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/nur";
    caarlos0-nur.url = "github:caarlos0/nur";
    x0ba-nur.url = "github:x0ba/nur";
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.flake-compat.follows = "";
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
    sops.inputs.nixpkgs-stable.follows = "nixpkgs";
    sops.inputs.nixpkgs.follows = "nixpkgs";
    sops.url = "github:Mic92/sops-nix/1c673ba1053ad3e421fe043702237497bda0c621";
    nix-index-database.url = "github:Mic92/nix-index-database";
    swayfx.inputs.flake-compat.follows = "";
    swayfx.inputs.nixpkgs.follows = "nixpkgs";
    swayfx.url = "github:willpower3309/swayfx";

    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-utils.url = "github:numtide/flake-utils";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
  };

  outputs = {flake-parts, ...} @ inputs: let
    inherit (import ./machines/lib.nix {inherit inputs;}) mkSystems overlays;
  in
    flake-parts.lib.mkFlake {inherit inputs;}
    {
      flake = mkSystems [
        {
          host = "impetus";
          system = "aarch64-darwin";
          username = "daniel";
        }
        {
          host = "oven";
          system = "x86_64-linux";
          username = "daniel";
        }
        {
          host = "fridge";
          system = "x86_64-linux";
          username = "daniel";
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
            editorconfig-checker.enable = true;
            luacheck.enable = true;
            nil.enable = true;
            stylua.enable = true;
          };
        };

        devShells.default = config.pre-commit.devShell.overrideAttrs (_old: {
          buildInputs = with pkgs; [gum just nix-output-monitor nvd sops];
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
    commit-lockfile-summary = "chore: update";
    extra-substituters = [
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store/?priority=10"
      "https://cache.nixos.org?priority=7"
      "https://nix-community.cachix.org?priority=5"
      "https://cache.garnix.io"
    ];
    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
    ];
  };
}
