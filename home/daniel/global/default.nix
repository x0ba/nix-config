{
  inputs,
  pkgs,
  config,
  outputs,
  ...
}: {
  imports =
    [
      ../features/cli
      ../features/neovim
      ../features/vscode
      inputs.sops-nix.homeManagerModules.sops
      inputs.nix-colors.homeManagerModule
      inputs.nix-index-database.hmModules.nix-index
    ]
    ++ (builtins.attrValues outputs.homeManagerModules);

  colorScheme = {
    slug = "oxocarbon";
    colors = {
      base00 = "161616";
      base01 = "262626";
      base02 = "393939";
      base03 = "525252";
      base04 = "dde1e6";
      base05 = "f2f4f8";
      base06 = "ffffff";
      base07 = "08bdba";
      base08 = "3ddbd9";
      base09 = "33b1ff";
      base0A = "ee5396";
      base0B = "78a9ff";
      base0C = "ff7eb6";
      base0D = "42be65";
      base0E = "be95ff";
      base0F = "82cfff";
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
        nekowinston-nur = import inputs.nekowinston-nur {inherit (prev) pkgs;};
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
