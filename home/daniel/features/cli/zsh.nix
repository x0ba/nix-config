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
      export LESSHISTFILE="-"
      export HISTFILE="${config.xdg.dataHome}/zsh/history"
      export EDITOR='nvim'
      export VISUAL='nvim'
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
        src = zsh-nix-shell;
        file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
      }
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
