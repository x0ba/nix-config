{inputs, ...}: {
  imports = [
    inputs.x0ba-nur.darwinModules.default
    ./programs/yabai.nix
    ./programs/skhd.nix
    ./brew.nix
    ./nix.nix
    ./system.nix
  ];
}
