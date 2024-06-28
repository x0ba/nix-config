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
  home = {
    packages = lib.attrValues {
      inherit
        (pkgs)
        bat
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
      extensions = import ./config/vscode/extensions.nix {inherit pkgs;};
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
      userEmail = "hey@x0ba.net";
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
}
