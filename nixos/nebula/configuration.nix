{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./brew.nix
    ./darwin
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];
  networking.computerName = "nebula";
  system.stateVersion = 4;
  services.nix-daemon.enable = true;
  nixpkgs.hostPlatform = "aarch64-darwin";
  security.pam.enableSudoTouchIdAuth = true;
  networking.hostName = "nebula";

  substituters = [
    "https://cache.nixos.org?priority=10"
    "https://cache.ngi0.nixos.org/"
    "https://nix-community.cachix.org"
    "https://aspect.cachix.org"
  ];

  trusted-public-keys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "cache.ngi0.nixos.org-1:KqH5CBLNSyX184S9BKZJo1LxrxJ9ltnY2uAs5c/f1MA="
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "aspect.cachix.org-1:HCNx0CCWqGPQzmSZiZLTiUZ/s4FUaufrSi85ZiKjS98="
  ];
}
