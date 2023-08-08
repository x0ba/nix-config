{...}: {
  imports = [
    ../shared/darwin/default.nix
  ];

  networking.computerName = "orion";
  networking.hostName = "orion";
}
