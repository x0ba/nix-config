{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: let
  theme = config.colorScheme;
in {
  programs.atuin = {
    enable = true;
    flags = ["--disable-up-arrow"];
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
      export LANG="en_US.UTF-8"
      export LC_COLLATE="en_US.UTF-8"
      export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#4d4d4d"
      export LC_CTYPE="en_US.UTF-8"
      export LC_MESSAGES="en_US.UTF-8"
      export LC_MONETARY="en_US.UTF-8"
      export LC_NUMERIC="en_US.UTF-8"
      export LC_TIME="en_US.UTF-8"
      export LC_ALL="en_US.UTF-8"
      export SUDO_PROMPT=$'Password for ->\033[32;05;16m %u\033[0m  '
    '';

    initExtra = with theme.colors; ''
      FZF_TAB_COMMAND=(
        ${pkgs.fzf}/bin/fzf
        --ansi
        --expect='$continuous_trigger'
        --nth=2,3 --delimiter='\x00'
        --layout=reverse --height="''${FZF_TMUX_HEIGHT:=50%}"
        --tiebreak=begin -m --bind=tab:down,btab:up,change:top,ctrl-space:toggle --cycle
        '--query=$query'
        '--header-lines=$#headers'
      )

        export FZF_DEFAULT_OPTS='
        --color fg:#${base06},bg:#${base00},hl:#${base04},fg+:#${base07},bg+:#${base00},hl+:#${base04},border:#${base03}
      --color pointer:#${base08},info:#${base03},spinner:#${base03},header:#${base03},prompt:#${base0B},marker:#${base0B}
      '
      zstyle ':fzf-tab:*' command $FZF_TAB_COMMAND
      zstyle ':fzf-tab:*' switch-group ',' '.'
      zstyle ':fzf-tab:complete:_zlua:*' query-string input
      zstyle ':fzf-tab:complete:*:*' fzf-preview 'preview $realpath'

      ZSH_AUTOSUGGEST_USE_ASYNC="true"
      ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor regexp root line)
      ZSH_HIGHLIGHT_MAXLENGTH=512

      any-nix-shell zsh --info-right | source /dev/stdin

      PATH=/opt/homebrew/bin:$PATH

    '';

    shellAliases = with pkgs; {
      cleanup = "sudo nix-collect-garbage --delete-older-than 7d";
      bloat = "nix path-info -Sh /run/current-system";
      g = "git";
      commit = "git add . && git commit -m";
      push = "git push";
      pull = "git pull";
      m = "mkdir -p";
      v = "${pkgs.neovim}/bin/nvim";
      t = "${pkgs.tmux}/bin/tmux";
      ta = "${pkgs.tmux}/bin/tmux attach -t";
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
        name = "zsh-autosuggestions";
        src = inputs.zsh-autosuggestions;
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
        name = "zsh-nix-shell";
        src = inputs.zsh-nix-shell;
        file = "nix-shell.plugin.zsh";
      }
    ];
  };
}
