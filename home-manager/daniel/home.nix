# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  flakePath,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.discocss.hmModule
    inputs.nix-colors.homeManagerModules.default
    inputs.sops-nix.homeManagerModules.sops

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix

    ../shared/secrets/sops.nix
    ../shared/programs/tmux
    ../shared/programs/lf
    ../shared/programs/kitty
    ../shared/programs/gpg
    ../shared/programs/git
    ../shared/programs/music
    ../shared/programs/starship
    ../shared/programs/browsers
    ../shared/programs/newsboat
    ../shared/programs/shell
    ../shared/xdg.nix
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
      inputs.nixpkgs-aspect.overlays.default
      inputs.nur.overlay

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })

      (final: prev: {
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

  # colorScheme = {
  #   slug = "oxocarbon";
  #   name = "oxocarbon";
  #   author = "Nyoom Engineering";
  #   colors = {
  #     base00 = "161616";
  #     base01 = "262626";
  #     base02 = "393939";
  #     base03 = "525252";
  #     base04 = "dde1e6";
  #     base05 = "f2f4f8";
  #     base06 = "ffffff";
  #     base07 = "08bdba";
  #     base08 = "3ddbd9";
  #     base09 = "33b1ff";
  #     base0A = "ee5396";
  #     base0B = "78a9ff";
  #     base0C = "ff7eb6";
  #     base0D = "42be65";
  #     base0E = "be95ff";
  #     base0F = "82cfff";
  #   };
  # };
  colorScheme = inputs.nix-colors.colorSchemes.tomorrow-night;

  home = {
    file = {
      ".local/bin/run" = {
        # Preview script for fzf tab
        executable = true;
        text = import ../shared/bin/run.nix {inherit pkgs;};
      };

      ".local/bin/preview" = {
        # Preview script for fzf tab
        executable = true;
        text = import ../shared/bin/preview.nix {inherit pkgs;};
      };

      ".tree-sitter".source = pkgs.runCommand "grammars" {} ''
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
        lutgen
        wezterm-git
        ripgrep
        fd
        file
        any-nix-shell
        neovide
        just
        nvd
        commitizen
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
