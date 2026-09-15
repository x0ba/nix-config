{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./homebrew.nix
    ./defaults.nix
  ];
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    (final: prev: {
      stable = import inputs.nixpkgs-stable {
        system = final.stdenv.hostPlatform.system;
        config.allowUnfree = true;
      };
    })
  ];

  # The existing Determinate installation owns the Nix daemon.
  nix.enable = false;
  # This macOS installation rejects replacing the system PAM include.
  security.pam.services.sudo_local.enable = false;
  system.primaryUser = "daniel";
  system.stateVersion = 6;
  networking.computerName = "Daniel’s MacBook Pro";
  networking.localHostName = "Daniels-MacBook-Pro";
  users.users.daniel = {
    home = "/Users/daniel";
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;
  programs.fish.enable = true;
  environment.shells = [
    pkgs.zsh
    pkgs.bashInteractive
    pkgs.fish
  ];
  environment.systemPath = lib.mkAfter [
    "/opt/homebrew/bin"
    "/opt/homebrew/sbin"
  ];
  fonts.packages = with pkgs; [
    atkinson-hyperlegible
    fira-code
    geist-font
    jetbrains-mono
  ];
}
