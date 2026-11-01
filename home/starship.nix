{ lib, pkgs, ... }:
{
  # Starship's "pure" preset gives every shell the minimal Pure-style prompt.
  programs.starship = {
    enable = true;
    presets = [ "pure-preset" ];

    # Puts jj-starship on the PATH of the wrapped starship binary, so the
    # custom.jj module below can run it.
    extraPackages = [ pkgs.jj-starship ];

    settings = {
      # The pure preset's format with git_branch/git_status swapped for
      # jj-starship, which reports on both jj and plain git repositories.
      format = lib.concatStrings [
        "$username"
        "$hostname"
        "$directory"
        "\${custom.jj}"
        "$git_state"
        "$cmd_duration"
        "$line_break"
        "$python"
        "$character"
      ];

      git_branch.disabled = true;
      git_status.disabled = true;

      custom.jj = {
        when = "jj-starship detect";
        # --no-*-prefix drops the "on" word; the change id/bookmark path
        # already reads like "koztzvsz (main~1)".
        shell = [
          "jj-starship"
          "--no-jj-prefix"
          "--no-git-prefix"
        ];
        # jj-starship emits its own ANSI colors, so pass $output straight
        # through instead of styling it with starship.
        format = "$output ";
      };
    };

    enableFishIntegration = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
    enableBashIntegration = false;
  };
}
