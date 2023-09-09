{ inputs
, outputs
, ...
}: {
  imports =
    [
      ../features/cli
      ../features/neovim
      ../features/vscode
      inputs.nix-colors.homeManagerModule
      inputs.caarlos0-nur.homeManagerModules.default
      inputs.nekowinston-nur.homeManagerModules.default
      inputs.nix-index-database.hmModules.nix-index
    ]
    ++ (builtins.attrValues outputs.homeManagerModules);

  colorScheme = {
    slug = "yoru";
    name = "Yoru";
    author = "rxyhn";
    colors = {
      base00 = "#0c0e0f";
      base01 = "#121415";
      base02 = "#161819";
      base03 = "#1f2122";
      base04 = "#27292a";
      base05 = "#edeff0";
      base06 = "#e4e6e7";
      base07 = "#f2f4f5";
      base08 = "#f26e74";
      base09 = "#ecd28b";
      base0A = "#e79881";
      base0B = "#82c29c";
      base0C = "#6791C9";
      base0D = "#709ad2";
      base0E = "#c58cec";
      base0F = "#e8646a";
    };
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
        caarlos0-nur = import inputs.caarlos0-nur { inherit (prev) pkgs; };
      })
      inputs.nekowinston-nur.overlays.default
      inputs.nix-vscode-extensions.overlays.default
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
