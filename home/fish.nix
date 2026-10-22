{ inputs, pkgs, ... }:
{
  programs.fish = {
    enable = true;

    plugins =
      map
        (name: {
          inherit name;
          src = inputs.${name};
        })
        [
          "fish-foreign-env"
          "theme-bobthefish"
        ];

    # No greeting on startup.
    functions.fish_greeting = "";

    # Start a nix-shell that drops into fish, e.g. `fnix -p go`.
    shellAliases.fnix = "nix-shell --run fish";

    interactiveShellInit = ''
      source ${inputs.theme-bobthefish}/functions/fish_prompt.fish
      source ${inputs.theme-bobthefish}/functions/fish_right_prompt.fish
      source ${inputs.theme-bobthefish}/functions/fish_title.fish

      set -g theme_color_scheme dracula

      set -g fish_color_normal normal
      set -g fish_color_command F8F8F2
      set -g fish_color_quote F1FA8C
      set -g fish_color_redirection 8BE9FD
      set -g fish_color_end 50FA7B
      set -g fish_color_error FF5555
      set -g fish_color_param 5FFFFF
      set -g fish_color_comment 6272A4
      set -g fish_color_match --background=brblue
      set -g fish_color_selection white --bold --background=brblack
      set -g fish_color_search_match bryellow --background=brblack
      set -g fish_color_history_current --bold
      set -g fish_color_operator 00a6b2
      set -g fish_color_escape 00a6b2
      set -g fish_color_cwd green
      set -g fish_color_cwd_root red
      set -g fish_color_valid_path --underline
      set -g fish_color_autosuggestion BD93F9
      set -g fish_color_user brgreen
      set -g fish_color_host normal
      set -g fish_color_cancel -r
      set -g fish_pager_color_completion normal
      set -g fish_pager_color_description B3A06D yellow
      set -g fish_pager_color_prefix white --bold --underline
      set -g fish_pager_color_progress brwhite --background=cyan

      # Shorter nix-shell segment in the prompt: just "N".
      function __bobthefish_prompt_nix -S -d 'Display current nix environment'
          [ "$theme_display_nix" = 'no' -o -z "$IN_NIX_SHELL" ]
          and return

          __bobthefish_start_segment $color_nix
          echo -ns N ' '

          set_color normal
      end

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
