{
  config,
  lib,
  inputs',
  inputs,
  ...
}:
{
  options = {
    cli.enable = lib.mkEnableOption "enables cli tools";
  };

  config = lib.mkIf config.cli.enable {
    programs = {

      neovim = {
        enable = true;
        package = inputs'.nvim.packages.neovim;
      };

      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };

      home-manager = {
        enable = true;
        path = lib.mkForce "${inputs.home}";
      };

      starship = {
        enable = true;
        settings = {
          scan_timeout = 10;
          # prompt
          format = "$directory$git_branch$git_metrics$nix_shell$package$character";
          add_newline = false;
          line_break.disabled = true;
          directory.style = "cyan";
          character = {
            success_symbol = "[λ](green)";
            error_symbol = "[λ](red)";
          };
          # git
          git_branch = {
            style = "purple";
            symbol = "";
          };
          git_metrics = {
            disabled = false;
            added_style = "bold yellow";
            deleted_style = "bold red";
          };
          # package management
          package.format = "version [$version](bold green) ";
          nix_shell.symbol = " ";
        };
      };

      zoxide = {
        enable = true;
        enableZshIntegration = config.programs.zsh.enable;
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

      fzf = {
        enable = true;
        catppuccin.enable = true;
        enableZshIntegration = true;
      };

      bat = {
        enable = true;
        catppuccin.enable = true;
      };

      gpg = {
        enable = true;
        scdaemonSettings."disable-ccid" = true;
        settings = import ./config/gpg.nix;
      };

      btop = {
        enable = true;
        catppuccin.enable = true;
        settings = {
          vim_keys = true;
        };
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
    };
  };
}
