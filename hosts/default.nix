{inputs, ...}: {
  # nix-darwin configurations
  parts.darwinConfigurations.fermata = {
    system = "aarch64-darwin";
    stateVersion = 4; # only change this if you know what you are doing.
    modules = [
      ./fermata/configuration.nix
    ];
  };

  # NixOS configurations
  parts.nixosConfigurations = {
    symphony = {
      system = "x86_64-linux";
      stateVersion = "23.05";
      server = true;

      modules = [
        inputs.nix-minecraft.nixosModules.minecraft-servers
        ./symphony/configuration.nix
      ];
    };

    sonata = {
      system = "x86_64-linux";
      stateVersion = "22.11"; # only change this if you know what you are doing.

      modules = [./starcruiser/configuration.nix];
    };

    fugue = {
      system = "x86_64-linux";
      stateVersion = "22.05"; # only change this if you know what you are doing.
      wsl = true;

      modules = [./fugue/configuration.nix];
    };
  };
}
