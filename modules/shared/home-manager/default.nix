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
  # imports = [
  #   ./config/vscode/extensions.nix
  # ];
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
      inherit (inputs'.agenix.packages) agenix;
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
      enable = false;
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

    tmux = {
      enable = true;
      sensibleOnTop = false;
      extraConfig = ''
        set -g default-terminal "xterm-256color"
        set -ag terminal-overrides ",xterm-256color:RGB"
        set-option -g default-shell ${pkgs.zsh}/bin/zsh
        set -g status-keys vi


        set-window-option -g mode-keys vi
        bind h select-pane -L
        bind j select-pane -D
        bind k select-pane -U
        bind l select-pane -R

        bind-key x kill-pane

        set -g set-titles-string ' #{pane_title} '

        bind-key / copy-mode \; send-key ?

        bind -n M-Left select-pane -L
        bind -n M-Right select-pane -R
        bind -n M-Up select-pane -U
        bind -n M-Down select-pane -D
        set -g mouse on
        set-option -g visual-activity off
        set-option -g visual-bell off
        set-option -g visual-silence off
        set-window-option -g monitor-activity off
        set-window-option -g mode-style bg=0,fg=default,noreverse
        set-window-option -g window-status-current-style bg=green,fg=black
        setw -g window-status-format " #I:#W#F "
        setw -g window-status-current-format " #I:#W#F "
        set-window-option -g window-status-style fg=green
        set-option -g renumber-windows on

        bind-key r source-file ~/.tmux.conf \; display-message "tmux.conf reloaded."


        # remap prefix from 'C-b' to 'C-s'
        unbind C-b
        set -g prefix C-s
        bind-key C-s send-prefix

        set-option -g bell-action none
        set -g status-position bottom
        set -g status-justify left
        set -g status-bg colour8
        set -g status-fg blue
        set -g status-right ' #(cd #{pane_current_path}; git rev-parse --abbrev-ref HEAD)    #{=50:pane_current_path}   %b %d %H:%M '
        set -g status-right-length 200
        set -g status-left '''
        set -sg escape-time 0

        set -g base-index 1
        setw -g pane-base-index 1
        set -g pane-border-format " #P: #{pane_current_command} "
      '';
      plugins = with pkgs.tmuxPlugins; [
        yank
      ];
    };

    gpg = {
      enable = true;
      scdaemonSettings."disable-ccid" = true;
      settings = import ./config/gpg.nix;
    };

    taskwarrior.enable = true;

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
