{ inputs, ... }: {
  imports = [
    inputs.home-manager.darwinModules.home-manager
    ../shared/darwin/default.nix
  ];

  networking.computerName = "orion";
  networking.hostName = "orion";
}
