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
}
