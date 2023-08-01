{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../shared/darwin/default.nix
  ];

  networking.computerName = "nebula";
  networking.hostName = "nebula";
}
