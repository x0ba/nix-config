{
  config,
  pkgs,
  lib,
  ...
}:
{
  home = {
    activation = {
      installCustomFonts =
        let
          fontDirectory =
            if pkgs.stdenv.isDarwin then
              "${config.home.homeDirectory}/Library/Fonts"
            else
              "${config.xdg.dataHome}/fonts";
          fontPath = ../../secrets/fonts;
        in

        lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          mkdir -p "${fontDirectory}"
          install -Dm644 ${fontPath}/* "${fontDirectory}"
        '';
    };
    packages = with pkgs; [
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

      # fonts
      (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
      ibm-plex
      alegreya
      inter
      atkinson-hyperlegible
    ];
  };

  programs = {
    emacs = {
      enable = true;
      extraPackages = epkgs: [
        epkgs.vterm
        epkgs.mu4e
      ];
      package = pkgs.emacs-macport;
    };

    firefox = {
      enable = true;
      package = (pkgs.writeScriptBin "__dummy-firefox" "");
      profiles.default = {
        search.default = "DuckDuckGo";
        search.force = true;
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          multi-account-containers
          temporary-containers
        ];
        settings = import ./config/firefox.nix;
      };
    };

    ghostty = {
      enable = true;

      settings = {
        mouse-hide-while-typing = true;
        unfocused-split-opacity = 0.8;

        quit-after-last-window-closed = true;
        macos-titlebar-style = "tabs";
        window-save-state = "never";

        cursor-style = "bar";

        macos-option-as-alt = true;
        clipboard-read = "allow";
        clipboard-paste-protection = false;
        confirm-close-surface = false;

        font-family = "Berkeley Mono";
        font-size = 13;

        theme = "catppuccin-mocha";

        window-padding-x = 10;
        window-height = 30;
        window-width = 120;
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
