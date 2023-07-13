{ inputs, config, lib, pkgs, ... }:

{
  imports = [
    ./brew.nix
    ./darwin
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.computerName = "nebula";
  system.stateVersion = 4;
  services.nix-daemon.enable = true;
  nixpkgs.hostPlatform = "aarch64-darwin";
  security.pam.enableSudoTouchIdAuth = true;
  networking.hostName = "nebula";
}
