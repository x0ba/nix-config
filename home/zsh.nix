{ ... }:
{
  # Replaces the hand-written ~/.bashrc so atuin etc. hook into bash via Nix too.
  programs.bash.enable = true;

  programs.zsh = {
    enable = true;

    defaultKeymap = "emacs";
    autocd = true;

    enableCompletion = true;
    autosuggestion.enable = true;

    syntaxHighlighting = {
      enable = true;
      highlighters = [
        "main"
        "brackets"
        "pattern"
        "line"
        "cursor"
        "root"
      ];
    };

    historySubstringSearch.enable = true;

    history = {
      size = 10000;
      save = 10000;
      extended = true;
      share = true;
      ignoreDups = true;
      ignoreAllDups = true;
      ignoreSpace = true;
      expireDuplicatesFirst = true;
    };

    shellAliases = {
      clde = "claude --dangerously-skip-permissions";
      ll = "ls -lh";
      la = "ls -lAh";
    };

    initContent = ''
      setopt AUTO_PUSHD PUSHD_IGNORE_DUPS PUSHD_SILENT PUSHD_TO_HOME
      setopt EXTENDED_GLOB INTERACTIVE_COMMENTS

      zstyle ':completion:*' menu select
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
      zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
    '';
  };
}
