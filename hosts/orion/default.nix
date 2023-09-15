{inputs, outputs, ...}: {
  imports = [
    ../shared/darwin/default.nix
    inputs.home-manager.darwinModules.home-manager
  ];


  home-manager = {
    extraSpecialArgs = {
      inherit inputs outputs;
      flakePath = "/Users/daniel/.config/nixpkgs";
    };
    useUserPackages = true;
    users = {
      # Import your home-manager configuration
      daniel = import ../../home/daniel/orion.nix;
    };
  };

  networking.computerName = "orion";
  networking.hostName = "orion";
}
