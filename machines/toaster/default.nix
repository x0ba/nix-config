{
  imports = [./brew.nix];

  networking.computerName = "toaster";
  networking.hostName = "toaster";

  nix.settings.extra-platforms = [
    "aarch64-darwin"
    "x86_64-darwin"
  ];
}
