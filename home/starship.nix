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
      # The pure preset's format, with its git modules replaced by custom
      # ones that pick a single VCS: jj-starship in jj repos, the preset's
      # own git_branch/git_status everywhere else.
      format = lib.concatStrings [
        "$username"
        "$hostname"
        "$directory"
        "\${custom.jj}"
        "\${custom.git_branch}"
        "$git_state"
        "\${custom.git_status}"
        "$cmd_duration"
        "$line_break"
        "$python"
        "$character"
      ];

      # Disabled here so the custom modules below can show them only when
      # there is no jj repo.
      git_branch.disabled = true;
      git_status.disabled = true;

      custom.jj = {
        # jj-starship also reports on plain git repos, so gate on jj itself.
        when = "jj --ignore-working-copy root >/dev/null 2>&1";
        # `command`, not `shell`: starship ignores a string `when` when
        # `shell` is set, which would show this module in every repo.
        # --no-jj-prefix drops the "on" word; the change id/bookmark path
        # already reads like "koztzvsz (main~1)".
        command = "jj-starship --no-jj-prefix";
        # jj-starship emits its own ANSI colors, so pass $output straight
        # through instead of styling it with starship.
        format = "$output ";
      };

      # Re-render the pure preset's git modules, which are disabled above.
      custom.git_branch = {
        when = "! jj --ignore-working-copy root >/dev/null 2>&1";
        command = "starship module git_branch";
        format = "$output";
      };

      custom.git_status = {
        when = "! jj --ignore-working-copy root >/dev/null 2>&1";
        command = "starship module git_status";
        format = "$output";
      };
    };

    enableFishIntegration = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
    enableBashIntegration = false;
  };
}
