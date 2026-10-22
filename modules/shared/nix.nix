{ lib, pkgs, user, ... }:
{
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    lib.elem (lib.getName pkg) [
      "claude-code"
      "cursor-cli"
    ];

  # On the Mac, Determinate Nix owns nix.conf, so only NixOS sets these.
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
