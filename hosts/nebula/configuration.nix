{...}: {
  imports = [
    ../shared/darwin/default.nix
  ];

  networking.computerName = "nebula";
  networking.hostName = "nebula";
}
