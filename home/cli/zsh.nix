{
  config,
  pkgs,
  flakePath,
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
in {
  programs = {
    zsh = {
      dotDir = ".config/zsh";
      dirHashes = {
        dl = "${config.home.homeDirectory}/Downloads";
        docs = "${config.home.homeDirectory}/Documents";
        code = "${config.home.homeDirectory}/Code";
        dots = "${config.xdg.configHome}/flake";
        pics = "${config.home.homeDirectory}/Pictures";
        cloud = "${config.home.homeDirectory}/Library/Mobile Documents/com~apple~CloudDocs";
      };
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
        run = "${pkgs.comma}/bin/,";
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
    "zsh/functions" = symlink "home/apps/zsh/functions" {recursive = true;};
  };
}
