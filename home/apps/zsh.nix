{
  config,
  pkgs,
  lib,
  ...
}: let
  theme = config.colorScheme;
  zshPlugins = plugins: (map
    (plugin: rec {
      name = src.name;
      inherit (plugin) file src;
    })
    plugins);
in {
  programs = {
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      autocd = true;
      enableCompletion = true;
      defaultKeymap = "viins";
      dotDir = ".config/zsh";
      history = {
        save = 10000;
        size = 10000;
        path = "${config.xdg.dataHome}/zsh/history";
      };
      envExtra = ''
        export LESSHISTFILE="${config.xdg.dataHome}"/less/history
        export FZF_DEFAULT_COMMAND="fd . --max-depth=1 --hidden"
        export SUDO_PROMPT=$'Password for ->\033[32;05;16m %u\033[0m  '
        export ANDROID_HOME="${config.xdg.dataHome}"/android
        export DOCKER_CONFIG="${config.xdg.dataHome}"/docker
        export EDITOR='nvim'
        export VISUAL='nvim'
        export ZVM_INIT_MODE="sourcing"
        export ZVM_CURSOR_BLINKING_BEAM="1"
        ZSH_AUTOSUGGEST_USE_ASYNC="true"
      '';
      initExtra = ''
        bindkey '^F' autosuggest-accept
        bindkey '^T' tms
        bindkey -a 'F' history-incremental-pattern-search-forward
        bindkey -a 'f' history-incremental-pattern-search-backward
      '';
      shellAliases = {
        cleanup = "sudo nix-collect-garbage --delete-older-than 7d";
        bloat = "nix path-info -Sh /run/current-system";
        g = "git";
        tree = "${pkgs.eza}/bin/eza --tree";
        gaa = "git add .";
        cls = "clear";
        commit = "git add . && git commit -m";
        m = "mkdir -p";
        push = "git push";
        pull = "git pull";
        cat = "${pkgs.bat}/bin/bat";
        nv = "${pkgs.neovim}/bin/nvim";
        fcd = "cd $(find -type d | fzf)";
        rm = "${pkgs.trash-cli}/bin/trash-put";
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
            "kubectl"
          ]
          ++ lib.optionals pkgs.stdenv.isDarwin [
            "dash"
            "macos"
          ];
      };
      plugins = with pkgs; (zshPlugins [
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
          src = zsh-vi-mode;
          file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
        }
        {
          src = zsh-nix-shell;
          file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
        }
        {
          src = zsh-fzf-tab;
          file = "share/fzf-tab/fzf-tab.plugin.zsh";
        }
      ]);
    };

    btop = {
      enable = true;
      settings = {
        theme_background = false;
        vim_keys = true;
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
  };
}
