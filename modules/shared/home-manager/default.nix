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
  imports = [
    ./config/vscode/extensions.nix
  ];
  home = {
    packages = lib.attrValues {
      inherit
        (pkgs)
        bat
        gopass
        ripgrep
        difftastic
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
    dircolors = {
      enable = true;
      enableFishIntegration = config.programs.fish.enable;

      extraConfig = lib.readFile (
        pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/trapd00r/LS_COLORS/3d833761506d6396f8331fcd11a32d9e3ad3ee80/LS_COLORS";
          hash = "sha256-r70V0JvQ/zlI/uYZ33OGl99qphCXtAgj6+Y3TXbJTLU=";
        }
      );
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    vscode = {
      enable = true;
      package = pkgs.vscodium;
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

    yazi = {
      enable = true;
      enableFishIntegration = config.programs.fish.enable;
    };

    git = {
      enable = true;
      userName = "x0ba";
      userEmail = "x0ba@tuta.io";
      signing = {
        signByDefault = true;
        key = "5C5C1EFB439B554A81341B1F20347137CA846F7F";
      };

      lfs.enable = true;

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
        init.defaultBranch = "main";
        diff.tool = "difftastic";
        pager.difftool = true;

        difftool = {
          prompt = false;
          difftastic.cmd = ''${lib.getExe pkgs.difftastic} "$LOCAL" "$REMOTE"'';
        };
      };
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    bat = {
      enable = true;
    };

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
        printf "\033[90mWelcome to %s, %s.\nIt's currently %s.\n\033[92m---,--'-{\033[91m@\033[m\n" "$(hostname)" "$USER" "$(date +'%A, %B %-d, %Y')"
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
      enableFishIntegration = config.programs.fish.enable;
    };

    fish = {
      enable = true;
      shellAbbrs = import ./config/sh-aliases.nix;

      interactiveShellInit = ''
        set -U fish_greeting
      '';
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
          patterns = ["*" "[Gmail]*"];
        };
        realName = "Daniel Xu";
        msmtp.enable = true;
      };
    };
  };
}
