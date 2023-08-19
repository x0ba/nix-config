{ inputs
, outputs
, lib
, pkgs
, config
, ...
}: {
  imports =
    [
      ../features/cli
      ../features/neovim
      ../features/vscode
      inputs.nix-colors.homeManagerModule
      inputs.nix-index-database.hmModules.nix-index
    ]
    ++ (builtins.attrValues outputs.homeManagerModules);

  colorScheme = inputs.nix-colors.colorSchemes.tomorrow-night;

  # symlinks don't work with finder + spotlight, copy them instead
  disabledModules = [ "targets/darwin/linkapps.nix" ];
  home.activation = lib.mkIf pkgs.stdenv.isDarwin {
    copyApplications =
      let
        apps = pkgs.buildEnv {
          name = "home-manager-applications";
          paths = config.home.packages;
          pathsToLink = "/Applications";
        };
      in
      lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        baseDir="$HOME/Applications/Home Manager Apps"
        if [ -d "$baseDir" ]; then
          rm -rf "$baseDir"
        fi
        mkdir -p "$baseDir"
        for appFile in ${apps}/Applications/*; do
          target="$baseDir/$(basename "$appFile")"
          $DRY_RUN_CMD cp ''${VERBOSE_ARG:+-v} -fHRL "$appFile" "$baseDir"
          $DRY_RUN_CMD chmod ''${VERBOSE_ARG:+-v} -R +w "$target"
        done
      '';
  };

  nixpkgs = {
    # You can add overlays here
    overlays = [
      outputs.overlays.modifications
      outputs.overlays.additions
      inputs.nur.overlay
      inputs.rust-overlay.overlays.default
      (_final: prev: {
        nur = import inputs.nur {
          nurpkgs = prev;
          pkgs = prev;
          repoOverrides = {
            caarlos0 = inputs.caarlos0-nur.packages.${prev.system};
            nekowinston = inputs.nekowinston-nur.packages.${prev.system};
          };
        };
        nekowinston-nur = import inputs.nekowinston-nur { inherit (prev) pkgs; };
        nix-vscode-extensions = inputs.nix-vscode-extensions.extensions.${prev.system};
      })
      inputs.nekowinston-nur.overlays.default
    ];

    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  systemd.user.startServices = "sd-switch";

  programs = {
    home-manager.enable = true;
    tealdeer.enable = true;
    taskwarrior.enable = true;
    nix-index-database.comma.enable = true;
  };
}
