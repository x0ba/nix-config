{
  imports = [./brew.nix];

  networking.computerName = "orion";
  networking.hostName = "orion";

  nix.settings.extra-platforms = [
    "aarch64-darwin"
    "x86_64-darwin"
  ];
}
