{
  imports = [./brew.nix];

  networking.computerName = "impetus";
  networking.hostName = "impetus";

  nix.settings.extra-platforms = [
    "aarch64-darwin"
    "x86_64-darwin"
  ];
}
