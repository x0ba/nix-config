{inputs, ...}: {
  # home-manager configurations
  parts.homeConfigurations = {
    "daniel@fermata" = {
      system = "aarch64-darwin";
      stateVersion = "23.05";

      modules = [
        ./daniel/home.nix
        inputs.ghostty.homeModules.default
      ];
    };

    "daniel@sonata" = {
      system = "x86_64-linux";
      stateVersion = "21.11";

      modules = [
        inputs.nix-colors.homeManagerModule
        ./omni/home.nix
      ];
    };

    "daniel@symphony" = {
      system = "x86_64-linux";
      stateVersion = "23.05";
      modules = [./volta/home.nix];
    };

    "zero@fugue" = {
      system = "x86_64-linux";
      stateVersion = "21.11";
      modules = [./zero/home.nix];
    };
  };
}
