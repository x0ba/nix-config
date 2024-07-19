{ self, inputs, ... }:
{
  imports = [
    ./home-manager.nix
    ./nix-darwin.nix
    ./nixos.nix
    ./devshell.nix
    ./precommit.nix
  ];

  perSystem =
    {
      lib,
      pkgs,
      system,
      inputs',
      ...
    }:
    {
      _module.args = rec {
        # nix the package manager configuration
        nix = import ./nix-settings.nix {
          inherit
            lib
            inputs
            inputs'
            pkgs
            ;
          inherit (pkgs) stdenv;
        };

        # nixpkgs configuration (not the flake input)
        nixpkgs = {
          config = lib.mkForce {
            allowBroken = true;
            allowUnfree = true;
            tarball-ttl = 0;

            # Experimental options, disable if you don't know what you are doing!
            contentAddressedByDefault = false;
          };

          hostPlatform = system;

          overlays = lib.mkForce [
            inputs.emacs.overlay
            inputs.nix-vscode-extensions.overlays.default
            inputs.nixpkgs-f2k.overlays.stdenvs
            self.overlays.default
          ];
        };

        # Extra arguments passed to the module system for nix-darwin, NixOS, and home-manager
        extraModuleArgs = {
          inherit inputs' system;
          inputs = lib.mkForce inputs;

          /*
            One can access these nixpkgs branches like so:

            `branches.stable.mpd'
            `branches.master.linuxPackages_xanmod'
          */
          branches =
            let
              pkgsFrom =
                branch: system:
                import branch {
                  inherit system;
                  inherit (nixpkgs) config overlays;
                };
            in
            {
              master = pkgsFrom inputs.master system;
              unstable = pkgsFrom inputs.unstable system;
              stable = pkgsFrom inputs.stable system;
            };
        };

        # NixOS and nix-darwin base environment.systemPackages
        basePackagesFor =
          pkgs:
          lib.attrValues {
            inherit (pkgs)
              nano
              curl
              fd
              ripgrep
              man-pages-posix
              wget
              git
              subversion
              ;

            home-manager = inputs'.home.packages.home-manager.override { path = "${inputs.home}"; };

            man-pages =
              if pkgs.stdenv.isLinux then pkgs.man-pages else inputs'.nixpkgs-f2k.packages.man-pages-xnu;

            gnu-coreutils = if pkgs.stdenv.isLinux then pkgs.coreutils else pkgs.coreutils-prefixed;
          };
      };

      formatter = pkgs.nixfmt-rfc-style;
    };
}
