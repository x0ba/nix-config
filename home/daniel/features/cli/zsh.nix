{ config
, pkgs
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
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    flags = [ "--disable-up-arrow" ];
    settings = {
      inline_height = 30;
      style = "compact";
    };
  };
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    dotDir = ".config/zsh";

    envExtra = ''
      export LESSHISTFILE="${config.xdg.dataHome}"/less/history
      export ANDROID_HOME="${config.xdg.dataHome}"/android
      export DOCKER_CONFIG="${config.xdg.dataHome}"/docker
      export HISTFILE="${config.xdg.dataHome}/zsh/history"
      export EDITOR='nvim'
      export VISUAL='nvim'
    '';

    completionInit = ''
      autoload -Uz compinit
      zstyle ':completion:*' menu select
      zstyle ':completion:*' menu yes select
      zstyle ':completion:*' sort false
      zstyle ':completion:*' completer _complete _match _approximate
      zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
      zstyle ':completion:*' special-dirs true
      zstyle ':completion:*' rehash true
      zstyle ':completion:*' list-grouped false
      zstyle ':completion:*' list-separator '''
      zstyle ':completion:*' group-name '''
      zstyle ':completion:*' verbose yes
      zstyle ':completion:*' file-sort modification
      zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
      zstyle ':completion:*:matches' group 'yes'
      zstyle ':completion:*:warnings' format '%F{red}%B-- No match for: %d --%b%f'
      zstyle ':completion:*:messages' format '%d'
      zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
      zstyle ':completion:*:descriptions' format '[%d]'
      zstyle ':completion:*:match:*' original only
      zstyle ':completion:*:approximate:*' max-errors 1 numeric
      zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
      zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
      zstyle ':completion:*:jobs' numbers true
      zstyle ':completion:*:jobs' verbose true
      zstyle ':completion:*:git-checkout:*' sort false
      zstyle ':completion:*:exa' sort false
      zstyle ':completion:complete:*:options' sort false
      zstyle ':completion:files' sort false
      zmodload zsh/zle
      zmodload zsh/zpty
      zmodload zsh/complist
      compinit -i
      _comp_options+=(globdots)

      autoload -Uz colors && colors

      bindkey -M menuselect 'h' vi-backward-char
      bindkey -M menuselect 'k' vi-up-line-or-history
      bindkey -M menuselect 'l' vi-forward-char
      bindkey -M menuselect 'j' vi-down-line-or-history
      bindkey -v '^?' backward-delete-char
    '';

    initExtra = with theme.colors; ''

      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi


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
          zstyle ':fzf-tab:*' switch-group ',' '.'
          zstyle ':fzf-tab:complete:_zlua:*' query-string input
          zstyle ':fzf-tab:complete:*:*' fzf-preview 'preview $realpath'

          ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor regexp root line)
          ZSH_HIGHLIGHT_MAXLENGTH=512

          any-nix-shell zsh --info-right | source /dev/stdin

          PATH=/usr/bin:/opt/homebrew/bin:/opt/homebrew/opt/libiconv/bin:~/Library/Python/3.9/bin:$PATH

    '';

    history.path = "${config.xdg.configHome}/zsh/history";

    shellAliases = {
      cleanup = "sudo nix-collect-garbage --delete-older-than 7d";
      bloat = "nix path-info -Sh /run/current-system";
      g = "git";
      gaa = "git add .";
      cls = "clear";
      commit = "git add . && git commit -m";
      nv = "neovide --frame buttonless";
      m = "mkdir -p";
      push = "git push";
      pull = "git pull";
      v = "${pkgs.neovim}/bin/nvim";
      vim = "${pkgs.neovim}/bin/nvim";
      fcd = "cd $(find -type d | fzf)";
      rm = "${pkgs.trash-cli}/bin/trash-put";
      cat = "${pkgs.bat}/bin/bat --style=plain";
    };

    plugins = with pkgs; (zshPlugins [
      {
        name = "powerlevel10k";
        src = zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = lib.cleanSource ./powerlevel;
        file = "powerlevel.zsh";
      }
      {
        src = zsh-nix-shell;
        file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
      }
      {
        src = zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
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
}
