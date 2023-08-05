# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    inputs.nix-colors.homeManagerModules.default
    inputs.sops-nix.homeManagerModules.sops
    inputs.nix-index-database.hmModules.nix-index
    {programs.nix-index-database.comma.enable = true;}

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix

    ../shared/secrets/sops.nix
    ../shared/programs/tmux
    ../shared/programs/lf
    ../shared/programs/alacritty
    ../shared/programs/kitty
    ../shared/programs/helix
    ../shared/programs/gpg
    ../shared/programs/git
    ../shared/programs/neofetch
    ../shared/bin
    # ../shared/programs/starship
    ../shared/programs/firefox
    ../shared/programs/newsboat
    ../shared/programs/shell
    ../shared/programs/xdg
    ../shared/programs/mail
    ../shared/programs/fonts
    ../shared/programs/sketchybar
    ../shared/programs/neovim
    ../shared/programs/zsh
    ../shared/programs/wezterm
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.modifications
      outputs.overlays.additions
      inputs.nur.overlay

      (_final: _prev: {
        wezterm = inputs.nekowinston-nur.packages.${pkgs.system}.wezterm-nightly;
      })
    ];

    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  colorScheme = inputs.nix-colors.colorSchemes.mountain;

  disabledModules = ["targets/darwin/linkapps.nix"];
  home = {
    activation = lib.mkIf pkgs.stdenv.isDarwin {
      copyApplications = let
        apps = pkgs.buildEnv {
          name = "home-manager-applications";
          paths = config.home.packages;
          pathsToLink = "/Applications";
        };
      in
        lib.hm.dag.entryAfter ["writeBoundary"] ''
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

    homeDirectory = "/Users/daniel";

    packages = lib.attrValues {
      inherit
        (pkgs)
        trash-cli
        git-lfs
        lutgen
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
        # Extras
        
        shellcheck
        imagemagick
        chafa
        jq
        elinks
        gcc
        glow
        fzf
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

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "23.05";
    username = "daniel";
  };

  programs = {
    home-manager.enable = true;
  };

  sops.secrets."wakatime-cfg".path = "${config.xdg.configHome}/wakatime/.wakatime.cfg";
  sops.secrets."ssh-cfg".path = "${config.home.homeDirectory}/.ssh/config";

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
