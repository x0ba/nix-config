{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    zsh.enable = lib.mkEnableOption "enables zsh";
  };

  config = lib.mkIf config.zsh.enable {
    programs.zsh = {
      enable = true;
      autocd = true;
      dotDir = ".config/zsh";
      autosuggestion.enable = true;
      autosuggestion.highlight = "fg=8";
      enableCompletion = true;
      historySubstringSearch.enable = true;
      syntaxHighlighting = {
        enable = true;
        catppuccin.enable = true;
      };
      shellAliases = import ./config/sh-aliases.nix;
      initExtra = ''
        export GPG_TTY="$(tty)"
        export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
        gpgconf --launch gpg-agent

        function secret {
          output="''${1}".$(date +%s).enc
          gpg --encrypt --armor --output ''${output} \
            -r $KEYID "''${1}" && echo "''${1} -> ''${output}"
        }
        function reveal {
          output=$(echo "''${1}" | rev | cut -c16- | rev)
          gpg --decrypt --output ''${output} "''${1}" && \
            echo "''${1} -> ''${output}"
        }

        function onefetch_in_git_dir {
          if [[ -d '.git' ]]; then
            ${pkgs.onefetch}/bin/onefetch --no-merges --no-bots --no-color-palette --true-color=never --text-colors 1 1 3 4 4
          fi
        }

        add-zsh-hook chpwd onefetch_in_git_dir
      '';
      plugins = [
        {
          name = "zsh-nix-shell";
          src = pkgs.zsh-nix-shell;
          file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
        }
        {
          name = "zsh-fzf-tab";
          src = pkgs.zsh-fzf-tab;
          file = "share/fzf-tab/fzf-tab.plugin.zsh";
        }
      ];
    };
  };
}
