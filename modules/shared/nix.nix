{
  lib,
  pkgs,
  inputs,
  user,
  ...
}:
let
  unfreePackages = [
    "claude-code"
    "cursor-cli"
  ];
  allowUnfreePredicate = pkg: lib.elem (lib.getName pkg) unfreePackages;
in
{
  nixpkgs.config = { inherit allowUnfreePredicate; };

  nixpkgs.overlays = [
    (
      _final: prev:
      let
        unstable = import inputs.nixpkgs-unstable {
          system = prev.stdenv.hostPlatform.system;
          config = { inherit allowUnfreePredicate; };
        };
      in
      {
        inherit (unstable)
          gh
          claude-code
          cursor-cli
          opencode
          hunk
          atuin
          jj-starship
          ;
      }
    )
  ];

  nix.settings = lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [
      "root"
      user
    ];
  };
}
