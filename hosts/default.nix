{ inputs, ... }:
let
  user = "daniel";

  homeManagerFor = platformModule: {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "before-nix";
      extraSpecialArgs = { inherit inputs user; };
      users.${user}.imports = [
        ../home
        platformModule
      ];
    };
  };
in
{
  flake = {
    darwinConfigurations."Daniels-MacBook-Pro-3" = inputs.nix-darwin.lib.darwinSystem {
      specialArgs = { inherit inputs user; };
      modules = [
        ../modules/shared/nix.nix
        ./darwin
        inputs.home-manager.darwinModules.home-manager
        (homeManagerFor ../home/darwin.nix)
      ];
    };

    nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs user; };
      modules = [
        ../modules/shared/nix.nix
        ./nixos
        inputs.home-manager.nixosModules.home-manager
        (homeManagerFor ../home/linux.nix)
      ];
    };
  };
}
