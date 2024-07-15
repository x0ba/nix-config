{
  config,
  pkgs,
  lib,
  ...
}: {
  home = {
    packages = lib.attrValues {
      inherit
        (pkgs)
        coreutils-prefixed
        curl
        fd
        ffmpeg
        gnugrep
        jq
        nil
        lazygit
        pandoc
        pfetch
        pinentry_mac
        ripgrep
        ;
    };

    sessionVariables = {
      MODULAR_HOME = "/Users/daniel/.local/share/modular";
      SSH_AUTH_SOCK = "${config.programs.gpg.homedir}/S.gpg-agent.ssh";
    };
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

    emacs = {
      enable = true;
      package = pkgs.emacs-macport;
      extraPackages = epkgs: [epkgs.vterm epkgs.mu4e];
    };

    ghostty = {
      enable = true;

      settings = {
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

        font-family = "SF Mono";
        font-size = 13;
        adjust-cell-width = "-5%";

        window-padding-x = 4;
        window-padding-y = 4;
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
