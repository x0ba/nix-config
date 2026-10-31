{ pkgs, ... }:
{
  programs.fish = {
    enable = true;

    # No greeting on startup.
    functions.fish_greeting = "";

    # Start a nix-shell that drops into fish, e.g. `fnix -p go`.
    shellAliases.fnix = "nix-shell --run fish";

    interactiveShellInit = ''
      # Ghostty can't auto-inject its shell integration because nix-darwin
      # overwrites XDG_DATA_DIRS, so source it by hand.
      if set -q GHOSTTY_RESOURCES_DIR
          source "$GHOSTTY_RESOURCES_DIR/shell-integration/fish/vendor_conf.d/ghostty-shell-integration.fish"
      end

      # Lets gpg ask for passphrases in the terminal.
      if isatty
          set -gx GPG_TTY (tty)
      end

      set -g SHELL ${pkgs.fish}/bin/fish
    '';
  };

  # Fish only. Zsh keeps agkozak.
  # Starship's pure preset: blue path, gray VCS info, purple ❯ on the next line.
  # jj-starship covers git and jj, so the built-in git modules stay off.
  # In a colocated repo git is usually detached, which would also surface git_commit.
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = false;
    enableZshIntegration = false;
    enableNushellIntegration = false;
    enableIonIntegration = false;

    extraPackages = [ pkgs.jj-starship ];
    settings = {
      format = "$username$hostname$directory\${custom.jj}$git_state$cmd_duration$line_break$python$character";

      directory.style = "blue";

      character = {
        success_symbol = "[❯](purple)";
        error_symbol = "[❯](red)";
        vimcmd_symbol = "[❮](green)";
      };

      git_branch.disabled = true;
      git_commit.disabled = true;
      git_status.disabled = true;

      git_state = {
        format = ''\([$state( $progress_current/$progress_total)]($style)\) '';
        style = "bright-black";
      };

      cmd_duration = {
        format = "[$duration]($style) ";
        style = "yellow";
      };

      # Virtualenv name only, same as the pure preset.
      python = {
        format = "[$virtualenv]($style) ";
        style = "bright-black";
        detect_extensions = [ ];
        detect_files = [ ];
      };

      custom.jj = {
        when = "jj-starship detect";
        shell = [
          "jj-starship"
          "--no-color"
          "--no-symbol"
          "--no-jj-prefix"
          "--no-git-prefix"
          "--no-jj-id"
          "--no-git-id"
        ];
        style = "bright-black";
        format = "[$output]($style) ";
      };
    };
  };

  home.packages = [ pkgs.jj-starship ];
}
