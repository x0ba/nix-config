{...}: {
  imports = [
    ../shared/darwin/default.nix
  ];

  networking.computerName = "frostbyte";
  networking.hostName = "frostbyte";
}
