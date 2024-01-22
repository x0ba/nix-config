{
  imports = [./brew.nix];

  networking.computerName = "fermata";
  networking.hostName = "fermata";

  nix.settings.extra-platforms = [
    "aarch64-darwin"
    "x86_64-darwin"
  ];
}
