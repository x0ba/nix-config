{ config
, lib
, inputs
, pkgs
, ...
}:
let
  theme = config.colorScheme;
in
{
  programs.atuin = {
    enable = true;
    flags = [ "--disable-up-arrow" ];
    settings = {
      inline_height = 30;
      style = "compact";
    };
  };
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    defaultKeymap = "viins";
    history = {
      save = 10000;
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    sessionVariables = {
      SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
    };

    envExtra = ''
      export LESSHISTFILE="-"
      export BACKUP_VOLUME_PATH="/Volumes/Lexar/backup"
      export ZVM_INIT_MODE="sourcing"
      export ZVM_CURSOR_BLINKING_BEAM="1"
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

            ZSH_AUTOSUGGEST_USE_ASYNC="true"
            ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor regexp root line)
            ZSH_HIGHLIGHT_MAXLENGTH=512

            any-nix-shell zsh --info-right | source /dev/stdin

            PATH=/usr/bin:/opt/homebrew/bin:~/.local/share/nvim/mason/bin:/opt/homebrew/opt/libiconv/bin:~/Library/Python/3.9/bin:$PATH

    '';

    shellAliases = with pkgs; {
      cleanup = "sudo nix-collect-garbage --delete-older-than 7d";
      bloat = "nix path-info -Sh /run/current-system";
      g = "git";
      gaa = "git add .";
      cls = "clear";
      commit = "git add . && git commit -m";
      m = "mkdir -p";
      push = "git push";
      pull = "git pull";
      v = "${pkgs.neovim}/bin/nvim";
      vim = "${pkgs.neovim}/bin/nvim";
      fcd = "cd $(find -type d | fzf)";
      rm = "${pkgs.trash-cli}/bin/trash-put";
      cat = "${pkgs.bat}/bin/bat --style=plain";
    };

    plugins = [
      {
        name = "zsh-completions";
        src = inputs.zsh-completions;
      }
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = lib.cleanSource ./conf;
        file = "powerlevel.zsh";
      }
      {
        name = "fzf-tab";
        src = inputs.fzf-tab;
      }
      {
        name = "zsh-syntax-highlighting";
        src = inputs.zsh-syntax-highlighting;
        file = "zsh-syntax-highlighting.zsh";
      }
      {
        name = "zsh-vi-mode";
        src = inputs.zsh-vi-mode;
      }
      {
        name = "zsh-nix-shell";
        src = inputs.zsh-nix-shell;
        file = "nix-shell.plugin.zsh";
      }
    ];
  };
}
