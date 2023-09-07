{ config
, pkgs
, lib
, ...
}:
let
  theme = config.colorScheme;
  zshPlugins = plugins: (map
    (plugin: rec {
      name = src.name;
      inherit (plugin) file src;
    })
    plugins);
in
{
  programs.zsh = {
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
    '';

    initExtra = with theme.colors; ''
      # if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
      #   source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      # fi

      setopt NO_NOMATCH

      set -k
      setopt auto_cd

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
      zstyle ':fzf-tab:*' switch-group ',' '.'
      zstyle ':fzf-tab:complete:_zlua:*' query-string input
      zstyle ':fzf-tab:complete:*:*' fzf-preview 'preview $realpath'

      ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor regexp root line)
      ZSH_HIGHLIGHT_MAXLENGTH=512
      ZSH_AUTOSUGGEST_USE_ASYNC="true"

      any-nix-shell zsh --info-right | source /dev/stdin

      bindkey '^F' autosuggest-accept
      bindkey -a 'F' history-incremental-pattern-search-forward
      bindkey -a 'f' history-incremental-pattern-search-backward
      bindkey -a 'k' history-substring-search-up
      bindkey -a 'j' history-substring-search-down
      bindkey '^[[A' history-substring-search-up
      bindkey '^[[B' history-substring-search-down
      bindkey -s '^O' ' _____smooth_fzf^M'
      bindkey -s '^P' _____toggle_right_prompt
      bindkey -s '^Y' _____toggle_left_prompt

      bindkey '^?' backward-delete-char
      bindkey '^H' backward-delete-char
      bindkey '^U' backward-kill-line

      umask 022
      zmodload zsh/zle
      zmodload zsh/zpty
      zmodload zsh/complist

      autoload -Uz colors
      autoload -U compinit
      colors

    '';

    shellAliases = {
      cleanup = "sudo nix-collect-garbage --delete-older-than 7d";
      bloat = "nix path-info -Sh /run/current-system";
      g = "git";
      gaa = "git add .";
      cls = "clear";
      commit = "git add . && git commit -m";
      m = "mkdir -p";
      push = "git push";
      pull = "git pull";
      nv = "${pkgs.neovim}/bin/nvim";
      fcd = "cd $(find -type d | fzf)";
      rm = "${pkgs.trash-cli}/bin/trash-put";
      cat = "${pkgs.bat}/bin/bat --style=plain";
    };

    plugins = with pkgs; (zshPlugins [
      # {
      #   name = "powerlevel10k";
      #   src = zsh-powerlevel10k;
      #   file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      # }
      # {
      #   name = "powerlevel10k-config";
      #   src = lib.cleanSource ./powerlevel;
      #   file = "powerlevel.zsh";
      # }
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
        name = "zsh-history-substring-search";
        src = zsh-history-substring-search;
        file = "share/zsh-history-substring-search/zsh-history-substring-search.zsh";
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
}
