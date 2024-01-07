{
  config,
  pkgs,
  flakePath,
  lib,
  ...
}: let
  symlink = fileName: {recursive ? false}: {
    source = config.lib.file.mkOutOfStoreSymlink "${flakePath}/${fileName}";
    recursive = recursive;
  };
  zshPlugins = plugins: (map
    (plugin: rec {
      name = src.name;
      inherit (plugin) file src;
    })
    plugins);
  catppuccin-zsh-fsh = pkgs.stdenvNoCC.mkDerivation {
    name = "catppuccin-zsh-fsh";
    src = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "zsh-fsh";
      rev = "7cdab58bddafe0565f84f6eaf2d7dd109bd6fc18";
      sha256 = "sha256-31lh+LpXGe7BMZBhRWvvbOTkwjOM77FPNaGy6d26hIA=";
    };
    phases = ["buildPhase"];
    buildPhase = ''
      mkdir -p $out/share/zsh/site-functions/themes
      ls $src/themes
      cp $src/themes/* $out/share/zsh/site-functions/themes/
    '';
  };
in {
  programs = {
    atuin = {
      enable = true;
      flags = ["--disable-up-arrow"];
      settings = {
        inline_height = 30;
        style = "compact";
      };
    };

    btop = {
      enable = true;
      settings = {
        theme_background = false;
        vim_keys = true;
      };
    };

    direnv.enable = true;
    direnv.nix-direnv.enable = true;

    fzf = {
      enable = true;
      defaultOptions = ["--height=30%" "--layout=reverse" "--info=inline"];
    };

    lsd = {
      enable = true;
      enableAliases = true;
      settings = {
        classic = false;
        blocks = ["permission" "user" "group" "size" "date" "name"];
        date = "+%y.%m.%d %H:%M";
        dereference = false;
        ignore-globs = [".git"];
        color = {
          when = "auto";
          theme = "custom";
        };
        icons = {
          when = "auto";
          theme = "fancy";
          separator = " ";
        };
        header = false;
        hyperlink = "auto";
        indicators = true;
        layout = "grid";
        permission = "octal";
        size = "default";
        sorting = {
          column = "name";
          dir-grouping = "first";
        };
        symlink-arrow = "󰌷";
      };
    };

    nix-index.enable = true;

    tealdeer = {
      enable = true;
      settings = {
        style = {
          description.foreground = "white";
          command_name.foreground = "green";
          example_text.foreground = "blue";
          example_code.foreground = "white";
          example_variable.foreground = "yellow";
        };
        updates.auto_update = true;
      };
    };

    zoxide = {
      enable = true;
      options = ["--cmd cd"];
    };

    bat = let
      src = pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "bat";
        rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
        sha256 = "sha256-6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
      };
    in {
      enable = true;
      themes = {
        "catppuccin-latte" = {
          inherit src;
          file = "Catppuccin-latte.tmTheme";
        };
        "catppuccin-frappe" = {
          inherit src;
          file = "Catppuccin-frappe.tmTheme";
        };
      };
    };

    zsh = {
      dotDir = ".config/zsh";
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      history.path = "${config.xdg.configHome}/zsh/history";
      initExtraFirst = ''
        zvm_config() {
          ZVM_VI_HIGHLIGHT_BACKGROUND="black"
          ZVM_VI_HIGHLIGHT_FOREGROUND="white"
          ZVM_INIT_MODE="sourcing"
          ZVM_INSERT_MODE_CURSOR="$ZVM_CURSOR_BLINKING_BEAM"
          ZVM_VI_HIGHLIGHT_EXTRASTYLE=bold,underline
        }
      '';
      initExtra = let
        functionsDir = "${config.home.homeDirectory}/${config.programs.zsh.dotDir}/functions";
      in ''
        for script in "${functionsDir}"/**/*; do
          source "$script"
        done
        bindkey '^F' autosuggest-accept
      '';
      envExtra = ''
        export LESSHISTFILE="-"
      '';
      shellAliases = {
        mv = "mv -i";
        cp = "cp -i";
        tree = "${pkgs.lsd}/bin/lsd --tree";
        cat = "${pkgs.bat}/bin/bat --theme='catppuccin-frappe'";
        rm = "${pkgs.trash-cli}/bin/trash-put";
        # switch between yubikeys for the same GPG key
        switch_yubikeys = ''gpg-connect-agent "scd serialno" "learn --force" "/bye"'';
      };
      oh-my-zsh = {
        enable = true;
        plugins =
          [
            "colored-man-pages"
            "colorize"
            "docker"
            "docker-compose"
            "git"
          ]
          ++ lib.optionals pkgs.stdenv.isDarwin [
            "dash"
            "macos"
          ];
      };
      plugins = with pkgs; (zshPlugins [
        {
          src = zsh-vi-mode.overrideAttrs (old: {
            src = fetchFromGitHub {
              inherit (old.src) repo owner;
              rev = "a3d717831c1864de8eabf20b946d66afc67e6695";
              hash = "sha256-peoyY+krpK/7dA3TW6PEpauDwZLe+riVWfwpFYnRn1Q=";
            };
          });
          file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
        }
        {
          src = zsh-fzf-tab;
          file = "share/fzf-tab/fzf-tab.plugin.zsh";
        }
        {
          src = zsh-nix-shell;
          file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
        }
        {
          src = zsh-fast-syntax-highlighting.overrideAttrs (_old: {
            src = fetchFromGitHub {
              owner = "zdharma-continuum";
              repo = "fast-syntax-highlighting";
              rev = "cf318e06a9b7c9f2219d78f41b46fa6e06011fd9";
              hash = "sha256-RVX9ZSzjBW3LpFs2W86lKI6vtcvDWP6EPxzeTcRZua4=";
            };
          });
          file = "share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh";
        }
      ]);
    };
  };

  xdg.configFile = {
    "fsh".source = "${catppuccin-zsh-fsh}/share/zsh/site-functions/themes";
    "zsh/functions" = symlink "home/apps/zsh/functions" {recursive = true;};
  };
}
