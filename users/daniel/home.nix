{
  config,
  inputs',
  pkgs,
  lib,
  ...
}: let
  srcs = pkgs.callPackage ../../_sources/generated.nix {};
in
  /*
  home-manager configuration
  Useful links:
  - Home Manager Manual: https://nix-community.gitlab.io/home-manager/
  - Appendix A. Configuration Options: https://nix-community.gitlab.io/home-manager/options.html
  */
  {
    home = {
      packages = lib.attrValues {
        inherit
          (pkgs)
          asitop
          avrdude
          blisp
          coreutils-prefixed
          curl
          doctl
          dua
          exiv2
          fanbox-dl
          fd
          ffmpeg
          gnugrep
          helix
          jq
          lazygit
          libheif
          nodejs_22
          oci-cli
          pandoc
          pfetch
          pinentry_mac
          ripgrep
          ;

        inherit (inputs'.nil.packages) nil;
      };

      sessionVariables = {
        MODULAR_HOME = "/Users/daniel/.local/share/modular";
        SSH_AUTH_SOCK = "${config.programs.gpg.homedir}/S.gpg-agent.ssh";
      };
    };

    xdg.configFile = {
      "wezterm/wezterm.lua".source = ./config/wezterm/wezterm.lua;
      "wezterm/config".source = ./config/wezterm/config;
      "wezterm/rose-pine-wezterm".source = srcs.rose-pine-wezterm.src;
    };

    programs = {
      fish = {
        interactiveShellInit = ''
          function export
            if [ $argv ]
              set var (echo $argv | cut -f1 -d=)
              set val (echo $argv | cut -f2 -d=)
              set -g -x $var $val
            else
              echo 'export var=value'
            end
          end
        '';

        shellInit = ''
          fish_add_path /Users/daniel/Library/Python/3.11/bin
          fish_add_path -m /Users/daniel/.local/share/miniconda/bin
          fish_add_path -amP /Applications/ArmGNUToolchain/13.2.Rel1/arm-none-eabi/bin
          fish_add_path -amP /usr/bin
          fish_add_path -amP /opt/homebrew/bin
          fish_add_path -amP /usr/local/smlnj/bin
          fish_add_path -amP /opt/local/bin
          fish_add_path -amP /opt/homebrew/opt/llvm/bin
          fish_add_path -amP /Users/daniel/.local/share/modular/pkg/packages.modular.com_mojo/bin
          fish_add_path -m /run/current-system/sw/bin
          fish_add_path -m /Users/daniel/.nix-profile/bin
        '';
      };

      wezterm.enable = true;

      ghostty = {
        enable = true;

        settings = {
          command = "${pkgs.fish}/bin/fish";
          mouse-hide-while-typing = true;
          unfocused-split-opacity = 0.8;

          quit-after-last-window-closed = true;
          macos-titlebar-style = "tabs";
          window-theme = "auto";
          theme = "GruvboxDark";

          cursor-style = "block";
          cursor-style-blink = false;

          macos-option-as-alt = true;
          clipboard-read = "allow";
          clipboard-paste-protection = false;
          confirm-close-surface = false;

          font-family = "Cascadia Code";
          font-size = 13;

          window-padding-x = 4;
          window-padding-y = 4;
          font-feature = [
            "calt"
            "ss01"
          ];
        };

        keybindings = {
          "super+left" = "goto_split:left";
          "super+right" = "goto_split:right";
          "super+up" = "goto_split:top";
          "super+down" = "goto_split:bottom";

          "super+control+left" = "resize_split:left,40";
          "super+control+right" = "resize_split:right,40";
          "super+control+up" = "resize_split:up,40";
          "super+control+down" = "resize_split:down,40";

          "page_up" = "scroll_page_fractional:-0.5";
          "page_down" = "scroll_page_fractional:0.5";
        };
      };
    };
  }
