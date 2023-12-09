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

  zshPlugins = plugins: (map
    (plugin: rec {
      name = src.name;
      inherit (plugin) file src;
    })
    plugins);
in {
  programs = {
    btop = {
      enable = true;
      settings = {
        theme_background = false;
        vim_keys = true;
      };
    };

    fzf = {
      enable = true;
    };

    starship.enable = true;

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
      enableZshIntegration = true;
      enableFishIntegration = true;
      options = ["--cmd cd"];
    };

    bat.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    lsd = {
      enable = true;
      enableAliases = true;
    };

    zsh = {
      dotDir = ".config/zsh";
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      history.path = "${config.xdg.configHome}/zsh/history";
      initExtraFirst = ''
        zvm_config() {
          ZVM_INIT_MODE=sourcing
          ZVM_CURSOR_STYLE_ENABLED=false
          ZVM_VI_HIGHLIGHT_BACKGROUND=black
          ZVM_VI_HIGHLIGHT_EXTRASTYLE=bold,underline
          ZVM_VI_HIGHLIGHT_FOREGROUND=white
        }
      '';
      initExtra = with config.lib.stylix.colors; let
        functionsDir = "${config.home.homeDirectory}/${config.programs.zsh.dotDir}/functions";
      in ''
        for script in "${functionsDir}"/**/*; do
          source "$script"
        done
        bindkey '^F' autosuggest-accept
        bindkey '^[[A' history-substring-search-up
        bindkey '^[[B' history-substring-search-down
        bindkey -M vicmd 'k' history-substring-search-up
        bindkey -M vicmd 'j' history-substring-search-down
      '';
      envExtra = ''
        export LESSHISTFILE="-"
        export MANPAGER='nvim +Man!'
      '';
      shellAliases = {
        mv = "mv -i";
        cp = "cp -i";
        tree = "${pkgs.lsd}/bin/lsd --tree";
        nv = "${pkgs.neovim}/bin/nvim";
        rm = "${pkgs.trash-cli}/bin/trash-put";
        # switch between yubikeys for the same GPG key
        switch_yubikeys = ''gpg-connect-agent "scd serialno" "learn --force" "/bye"'';
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
          src = fzf-zsh;
          file = "share/fzf-zsh/fzf-zsh.plugin.zsh";
        }
        {
          src = zsh-history-substring-search;
          file = "share/zsh-history-substring-search/zsh-history-substring-search.zsh";
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
    "lsd" = symlink "home/apps/lsd" {recursive = true;};
    "starship.toml" = symlink "home/apps/starship/config.toml" {};
  };
}
