{
  config,
  pkgs,
  inputs,
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
in {
  programs = {
    atuin = {
      enable = true;
      flags = ["--disable-up-arrow"];
      settings = {
        inline_height = 30;
        style = "compact";
        sync_frequency = "5m";
      };
    };
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
      options = ["--cmd cd"];
    };

    bat.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    eza = {
      enable = true;
      enableAliases = true;
      icons = true;
      extraOptions = [
        "--group-directories-first"
      ];
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
        if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
          source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
        fi
      '';
      initExtra = with config.lib.stylix.colors; let
        functionsDir = "${config.home.homeDirectory}/${config.programs.zsh.dotDir}/functions";
      in ''
        for script in "${functionsDir}"/**/*; do
          source "$script"
        done
        bindkey '^F' autosuggest-accept

        export FZF_DEFAULT_OPTS='
        --color fg:#${base06},bg:#${base00},hl:#${base04},fg+:#${base07},bg+:#${base00},hl+:#${base04},border:#${base03}
        --color pointer:#${base08},info:#${base03},spinner:#${base03},header:#${base03},prompt:#${base0B},marker:#${base0B}
        '

        FZF_TAB_COMMAND=(
          ${pkgs.fzf}/bin/fzf
          --ansi
          --expect='$continuous_trigger' # For continuous completion
          --nth=2,3 --delimiter='\x00'  # Don't search prefix
          --layout=reverse --height="''${FZF_TMUX_HEIGHT:=50%}"
          --tiebreak=begin -m --bind=tab:down,btab:up,change:top,ctrl-space:toggle --cycle
          '--query=$query'   # $query will be expanded to query string at runtime.
          '--header-lines=$#headers' # $#headers will be expanded to lines of headers at runtime
        )
        zstyle ':fzf-tab:*' command $FZF_TAB_COMMAND
      '';
      envExtra = ''
        export LESSHISTFILE="-"
        export MANPAGER='nvim +Man!'
      '';
      shellAliases = {
        mv = "mv -i";
        t = "${pkgs.tmux-sessionizer}/bin/tms";
        cp = "cp -i";
        tree = "${pkgs.eza}/bin/eza --tree";
        nv = "${pkgs.neovim}/bin/nvim";
        rm = "${pkgs.trash-cli}/bin/trash-put";
      };
      oh-my-zsh = {
        enable = true;
        plugins =
          [
            "colored-man-pages"
            "sudo"
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
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
        {
          name = "powerlevel10k-config";
          src = lib.cleanSource ./zsh;
          file = "powerlevel.zsh";
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
          src = zsh-nix-shell;
          file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
        }
      ]);
    };
  };

  xdg.configFile = {
    "zsh/functions" = symlink "home/apps/zsh/functions" {recursive = true;};
  };
}
