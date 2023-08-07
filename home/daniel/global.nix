{
  inputs,
  lib,
  pkgs,
  config,
  outputs,
  ...
}: {
  imports = [
    inputs.nix-colors.homeManagerModules.default
    inputs.sops-nix.homeManagerModules.sops
    inputs.nix-index-database.hmModules.nix-index
    {programs.nix-index-database.comma.enable = true;}
  ];
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

  home = {
    packages = lib.attrValues {
      inherit
        (pkgs)
        trash-cli
        git-lfs
        lutgen
        nix-inspect
        just
        ripgrep
        cmake
        fd
        file
        any-nix-shell
        commitizen
        git-crypt
        sops
        wireguard-tools
        wireguard-go
        cl
        preview
        updoot
        shellcheck
        imagemagick
        chafa
        jq
        elinks
        glow
        fzf
        luarocks
        exiftool
        sdcv
        sqlite
        statix
        pre-commit
        deadnix
        obsidian
        neovide
        ;
    };
  };

  programs = {
    home-manager.enable = true;
  };
}
