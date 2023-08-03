# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.discocss.hmModule
    inputs.nix-colors.homeManagerModules.default
    inputs.sops-nix.homeManagerModules.sops
    inputs.nix-index-database.hmModules.nix-index
    { programs.nix-index-database.comma.enable = true; }

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix

    ../shared/secrets/sops.nix
    ../shared/programs/tmux
    ../shared/programs/lf
    ../shared/programs/alacritty
    ../shared/programs/kitty
    ../shared/programs/gpg
    ../shared/programs/git
    ../shared/programs/neofetch
    ../shared/programs/starship
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

      (final: prev: {
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

  # colorScheme = {
  #   slug = "onedark";
  #   name = "onedark";
  #   colors = {
  #     base00 = "181b21";
  #     base01 = "353b45";
  #     base02 = "3e4451";
  #     base03 = "545862";
  #     base04 = "565c64";
  #     base05 = "abb2bf";
  #     base06 = "b6bdca";
  #     base07 = "c8ccd4";
  #     base08 = "e06c75";
  #     base09 = "d19a66";
  #     base0A = "e5c07b";
  #     base0B = "98c379";
  #     base0C = "56b6c2";
  #     base0D = "61afef";
  #     base0E = "c678dd";
  #     base0F = "be5046";
  #   };
  # };

  disabledModules = [ "targets/darwin/linkapps.nix" ];
  home = {
    activation = lib.mkIf pkgs.stdenv.isDarwin {
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
    file = {
      ".local/bin/run" = {
        # Script to run any program inside nix-shell
        executable = true;
        text = import ../shared/bin/run.nix { inherit pkgs; };
      };

      ".local/bin/updoot" = {
        # Upload any file to 0x0.st
        executable = true;
        text = import ../shared/bin/updoot.nix { inherit pkgs; };
      };

      ".local/bin/nix-search" = {
        # search nixpkgs with fzf
        executable = true;
        text = import ../shared/bin/nix-search.nix { inherit pkgs; };
      };

      ".local/bin/panes" = {
        # eyecandy
        executable = true;
        text = import ../shared/bin/panes.nix { inherit pkgs; };
      };

      ".local/bin/preview" = {
        # Preview script for fzf tab
        executable = true;
        text = import ../shared/bin/preview.nix { inherit pkgs; };
      };

      ".tree-sitter".source = pkgs.runCommand "grammars" { } ''
        mkdir -p $out/bin
        ${
          lib.concatStringsSep "\n" (lib.mapAttrsToList (name: src: "name=${name}; ln -s ${src}/parser $out/bin/\${name#tree-sitter-}.so")
            pkgs.tree-sitter.builtGrammars)
        };
      '';
    };

    homeDirectory = "/Users/daniel";

    packages = lib.attrValues {
      inherit
        (pkgs)
        trash-cli
        nixfmt
        shellcheck
        git-lfs
        lutgen
        just
        cargo
        rnix-lsp
        ripgrep
        cmake
        fd
        nil
        deadnix
        stylua
        file
        any-nix-shell
        commitizen
        sumneko-lua-language-server
        git-crypt
        sops
        wireguard-tools
        wireguard-go
        # Extras

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
        # general apps

        obsidian
        discord
        vscodium
        neovide
        karabiner-elements
        spotify
        iina
        ;
    };

    sessionPath = [
      "${config.home.homeDirectory}/.local/bin"
    ];

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
