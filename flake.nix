{
  description = "Starter Configuration with secrets for MacOS and NixOS";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    agenix.url = "github:ryantm/agenix";
    home-manager.url = "github:nix-community/home-manager";
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    secrets = {
      url = "git+ssh://git@github.com/x0ba/nix-secrets.git";
      flake = false;
    };
  };
  outputs =
    {
      self,
      darwin,
      home-manager,
      nixpkgs,
      disko,
      agenix,
      nix-index-database,
      secrets,
    }@inputs:
    let
      user = "daniel";
      linuxSystems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      darwinSystems = [
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      forAllSystems = f: nixpkgs.lib.genAttrs (linuxSystems ++ darwinSystems) f;
      devShell =
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default =
            with pkgs;
            mkShell {
              nativeBuildInputs = with pkgs; [
                bashInteractive
                git
                age
                age-plugin-yubikey
                nixfmt
                vim
                nix
                nh
                nixd
              ];
              shellHook = with pkgs; ''
                export EDITOR=vim
              '';
            };
        };
      mkApp = scriptName: system: description: {
        type = "app";
        program = "${
          (nixpkgs.legacyPackages.${system}.writeScriptBin scriptName ''
            #!/usr/bin/env bash
            PATH=${nixpkgs.legacyPackages.${system}.git}/bin:$PATH
            echo "Running ${scriptName} for ${system}"
            exec ${self}/apps/${system}/${scriptName}
          '')
        }/bin/${scriptName}";
        meta = {
          inherit description;
        };
      };
      mkLinuxApps = system: {
        "apply" = mkApp "apply" system "Interactive setup to customize configuration";
        "build-switch" = mkApp "build-switch" system "Build and switch to new NixOS generation";
        "clean" = mkApp "clean" system "Remove old system generations";
        "copy-keys" = mkApp "copy-keys" system "Copy age keys to remote host";
        "create-keys" = mkApp "create-keys" system "Generate age encryption keys";
        "check-keys" = mkApp "check-keys" system "Verify age keys are configured";
        "install" = mkApp "install" system "Fresh NixOS system install";
        "install-with-secrets" = mkApp "install-with-secrets" system "Install NixOS with agenix secrets";
      };
      mkDarwinApps = system: {
        "apply" = mkApp "apply" system "Interactive setup to customize configuration";
        "build" = mkApp "build" system "Build configuration without switching";
        "build-switch" = mkApp "build-switch" system "Build and switch to new Darwin generation";
        "clean" = mkApp "clean" system "Remove old system generations";
        "copy-keys" = mkApp "copy-keys" system "Copy age keys to remote host";
        "create-keys" = mkApp "create-keys" system "Generate age encryption keys";
        "check-keys" = mkApp "check-keys" system "Verify age keys are configured";
        "rollback" = mkApp "rollback" system "Revert to previous generation";
      };
    in
    {
      devShells = forAllSystems devShell;

      formatter = {
        x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt;
        aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixfmt;
      };

      apps =
        nixpkgs.lib.genAttrs linuxSystems mkLinuxApps // nixpkgs.lib.genAttrs darwinSystems mkDarwinApps;

      # Expose system configurations as packages for nh compatibility
      packages = {
        aarch64-darwin = {
          mba = self.darwinConfigurations.mba.system;
        };
        x86_64-linux = {
          tp = self.nixosConfigurations.tp.config.system.build.toplevel;
        };
      };

      darwinConfigurations = {
        mba = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = inputs;
          modules = [
            home-manager.darwinModules.home-manager
            nix-index-database.darwinModules.nix-index
            { programs.nix-index-database.comma.enable = true; }
            ./hosts/darwin
          ];
        };
      };

      nixosConfigurations = {
        tp = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = inputs;
          modules = [
            disko.nixosModules.disko
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${user} = import ./modules/nixos/home-manager.nix;
              };
            }
            ./hosts/nixos
          ];
        };
      };
    };
}
