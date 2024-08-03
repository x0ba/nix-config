{
  config,
  inputs,
  inputs',
  lib,
  pkgs,
  ...
}:
/*
  home-manager configuration
  Useful links:
  - Home Manager Manual: https://nix-community.gitlab.io/home-manager/
  - Appendix A. Configuration Options: https://nix-community.gitlab.io/home-manager/options.html
*/
{
  imports = [ ./config/vscode/extensions.nix ];
  home = {
    packages = lib.attrValues {
      inherit (pkgs)
        bat
        rs-git-fsmonitor
        nixd
        watchman
        yubikey-personalization
        yubikey-manager
        borgmatic
        gopass
        ripgrep
        ;

      inherit (pkgs.gitAndTools) gh;
      inherit (inputs'.nvim.packages) neovim;
    };

    sessionVariables = {
      EDITOR = "nvim";
      MANPAGER = "nvim +Man! -c 'nnoremap i <nop>'";
    };
  };

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    vscode = {
      enable = true;
      userSettings = builtins.fromJSON (lib.readFile ./config/vscode/settings.json);
      keybindings = builtins.fromJSON (lib.readFile ./config/vscode/keybindings.json);
    };

    eza = {
      enable = true;
      icons = true;
      extraOptions = [
        "--group"
        "--group-directories-first"
        "--no-permissions"
        "--octal-permissions"
      ];
    };

    neovim.enable = true;

    git = {
      enable = true;
      userName = "x0ba";
      userEmail = "danielxu0307@proton.me";
      signing = {
        signByDefault = true;
        key = "0x660DBDE129F4E1D9";
      };

      lfs.enable = true;

      diff-so-fancy.enable = true;

      aliases = {
        df = "difftool";
        a = "add";
        p = "push";
        r = "rebase";
        ri = "rebase -i";
        cm = "commit";
        pl = "pull";
        s = "status";
        st = "stash";
        ck = "checkout";
        rl = "reflog";
      };

      ignores = [
        # general
        "*.log"
        ".DS_Store"
        # editors
        "*.swp"
        ".gonvim/"
        ".idea/"
        "ltex.*.txt"
        # nix-specific
        ".direnv/"
        ".envrc"
      ];

      extraConfig = {
        core.fsmonitor = "rs-git-fsmonitor";
        init.defaultBranch = "main";
        push.default = "current";
        push.gpgSign = "if-asked";
        rebase.autosquash = true;
        url = {
          "https://github.com/".insteadOf = "gh:";
          "https://github.com/x0ba/".insteadOf = "x0ba:";
          "https://gitlab.com/".insteadOf = "gl:";
        };
      };
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    bat.enable = true;

    zsh = {
      enable = true;
      autocd = true;
      dotDir = ".config/zsh";
      autosuggestion.enable = true;
      autosuggestion.highlight = "fg=8";
      enableCompletion = true;
      historySubstringSearch.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = import ./config/sh-aliases.nix;
      initExtra = ''
        export GPG_TTY="$(tty)"
        export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
        gpg-connect-agent updatestartuptty /bye > /dev/null

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

    gpg = {
      enable = true;
      scdaemonSettings."disable-ccid" = true;
      settings = import ./config/gpg.nix;
    };

    home-manager = {
      enable = true;
      path = lib.mkForce "${inputs.home}";
    };

    htop = {
      enable = true;

      settings =
        {
          detailed_cpu_time = true;
          hide_kernel_threads = false;
          show_cpu_frequency = true;
          show_cpu_usage = true;
          show_program_path = false;
          show_thread_names = true;

          fields = with config.lib.htop.fields; [
            PID
            USER
            PRIORITY
            NICE
            M_SIZE
            M_RESIDENT
            M_SHARE
            STATE
            PERCENT_CPU
            PERCENT_MEM
            TIME
            COMM
          ];
        }
        // (
          with config.lib.htop;
          leftMeters [
            (bar "AllCPUs")
            (bar "Memory")
            (bar "Swap")
          ]
        )
        // (
          with config.lib.htop;
          rightMeters [
            (text "Tasks")
            (text "LoadAverage")
            (text "Uptime")
          ]
        );
    };

    nix-index-database.comma.enable = lib.mkDefault true;

    msmtp.enable = true;
    mbsync.enable = true;
    mu.enable = true;

    starship = {
      enable = true;
      settings = import ./config/starship.nix;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = config.programs.zsh.enable;
    };
  };

  accounts.email = {
    maildirBasePath = "${config.home.homeDirectory}/.mail";
    accounts = {
      personalgmail = {
        address = "danielxu0307@gmail.com";
        userName = "danielxu0307@gmail.com";
        flavor = "gmail.com";
        passwordCommand = "${pkgs.gopass}/bin/gopass mail/personalgmail";
        primary = true;
        mbsync = {
          enable = true;
          create = "both";
          expunge = "both";
          patterns = [
            "*"
            "[Gmail]*"
          ];
        };
        realName = "Daniel Xu";
        msmtp.enable = true;
      };
    };
  };
}
