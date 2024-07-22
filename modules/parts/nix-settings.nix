{
  lib,
  pkgs,
  stdenv,
  inputs,
  ...
}:
# Nix daemon settings that can't be put in `nixConfig`.
{
  extraOptions = ''
    keep-outputs = true
    keep-derivations = true
    auto-allocate-uids = true
    http-connections = 0
  '';

  nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  package = pkgs.nixVersions.latest;

  registry = {
    system.flake = inputs.self;
    default.flake = inputs.nixpkgs;
    nixpkgs.flake = inputs.nixpkgs;
    templates.flake = inputs.templates;
    home-manager.flake = inputs.home;
  };

  settings = lib.mkMerge [
    {
      accept-flake-config = true;
      flake-registry = builtins.toFile "begone-evil.json" (
        builtins.toJSON {
          flakes = [ ];
          version = 2;
        }
      );

      experimental-features = [
        "auto-allocate-uids"
        "ca-derivations"
        "flakes"
        "nix-command"
        # "configurable-impure-env"
      ];

      max-jobs = "auto";

      trusted-substituters = [
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store?priority=10"
        "https://mirror.sjtu.edu.cn/nix-channels/store?priority=10"
        "https://mirrors.ustc.edu.cn/nix-channels/store?priority=15"
        "https://mirrors.cernet.edu.cn/nix-channels/store?priority=15"
        "https://mirrors.cqupt.edu.cn/nix-channels/store?priority=15"
        "https://mirror.iscas.ac.cn/nix-channels/store?priority=15"
        "https://mirror.nju.edu.cn/nix-channels/store?priority=15"
        "https://mirrors4.sau.edu.cn/nix-channels/store?priority=15"
        "https://nix-mirror.freetls.fastly.net?priority=11"
        "https://pre-commit-hooks.cachix.org"
        "https://cache.nixos.org?priority=12"
        "https://nix-community.cachix.org?priority=13"
        "https://nixpkgs-wayland.cachix.org"
      ];

      trusted-public-keys = [
        "pre-commit-hooks.cachix.org-1:Pkk3Panw5AW24TOv6kz3PvLhlH8puAsJTBbOPmBo7Rc="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      ];

      trusted-users = [
        "root"
        "daniel"
        "zero"
      ];

      use-xdg-base-directories = true;
    }

    (lib.mkIf (stdenv.isDarwin && stdenv.isAarch64) { extra-platforms = "x86_64-darwin"; })
  ];
}
