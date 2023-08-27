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

  colorScheme = inputs.nix-colors.colorSchemes.mountain;

  # colorScheme = {
  #   slug = "darkppuccin";
  #   name = "darkppuccin";
  #   author = "x0ba (https://github.com/x0ba)";
  #   colors = {
  #     base00 = "000000"; # base
  #     base01 = "010101"; # mantle
  #     base02 = "313244"; # surface0
  #     base03 = "45475a"; # surface1
  #     base04 = "585b70"; # surface2
  #     base05 = "cdd6f4"; # text
  #     base06 = "f5e0dc"; # rosewater
  #     base07 = "b4befe"; # lavender
  #     base08 = "f38ba8"; # red
  #     base09 = "fab387"; # peach
  #     base0A = "f9e2af"; # yellow
  #     base0B = "a6e3a1"; # green
  #     base0C = "94e2d5"; # teal
  #     base0D = "89b4fa"; # blue
  #     base0E = "cba6f7"; # mauve
  #     base0F = "f2cdcd"; # flamingo
  #   };
  # };

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
    taskwarrior.enable = true;
    nix-index-database.comma.enable = true;
  };
}
