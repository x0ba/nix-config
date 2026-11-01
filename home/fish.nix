{ pkgs, ... }:
let
  bobthefish = pkgs.fishPlugins.bobthefish.src;
in
{
  programs.fish = {
    enable = true;

    # No greeting on startup.
    functions.fish_greeting = "";

    # Start a nix-shell that drops into fish, e.g. `fnix -p go`.
    shellAliases.fnix = "nix-shell --run fish";

    interactiveShellInit = ''
      # bobthefish prompt, sourced by hand instead of through
      # programs.fish.plugins so the functions are loaded before the
      # overrides further down.
      source ${bobthefish}/functions/__bobthefish_colors.fish
      source ${bobthefish}/functions/__bobthefish_glyphs.fish
      source ${bobthefish}/functions/fish_prompt.fish
      source ${bobthefish}/functions/fish_right_prompt.fish
      source ${bobthefish}/functions/fish_title.fish

      set -g theme_color_scheme dracula

      # Fish's own colors, on top of the dracula prompt. Universal like the
      # original config, so they win over fish's built-in globals.
      set -U fish_color_normal normal
      set -U fish_color_command F8F8F2
      set -U fish_color_quote F1FA8C
      set -U fish_color_redirection 8BE9FD
      set -U fish_color_end 50FA7B
      set -U fish_color_error FF5555
      set -U fish_color_param 5FFFFF
      set -U fish_color_comment 6272A4
      set -U fish_color_match --background=brblue
      set -U fish_color_selection white --bold --background=brblack
      set -U fish_color_search_match bryellow --background=brblack
      set -U fish_color_history_current --bold
      set -U fish_color_operator 00a6b2
      set -U fish_color_escape 00a6b2
      set -U fish_color_cwd green
      set -U fish_color_cwd_root red
      set -U fish_color_valid_path --underline
      set -U fish_color_autosuggestion BD93F9
      set -U fish_color_user brgreen
      set -U fish_color_host normal
      set -U fish_color_cancel -r
      set -U fish_pager_color_completion normal
      set -U fish_pager_color_description B3A06D yellow
      set -U fish_pager_color_prefix white --bold --underline
      set -U fish_pager_color_progress brwhite --background=cyan

      # Concise nix shell segment: just "N" instead of the environment name.
      function __bobthefish_prompt_nix -S -d 'Display current nix environment'
          [ "$theme_display_nix" = 'no' -o -z "$IN_NIX_SHELL" ]
          and return

          __bobthefish_start_segment $color_nix
          echo -ns N ' '

          set_color normal
      end

      # In a jj repo, show a plain "jj" instead of the git branch and status.
      # Non-colocated jj repos have no .git, so find their root by walking up
      # to the nearest .jj directory.
      functions -c __bobthefish_git_project_dir __bobthefish_git_project_dir_git
      function __bobthefish_git_project_dir -S -a real_pwd -d 'Print the current git or jj project base directory'
          set -l git_root (__bobthefish_git_project_dir_git $real_pwd)
          if [ "$git_root" ]
              echo $git_root
              return
          end

          set -l dir $real_pwd
          while test -n "$dir"
              if test -d $dir/.jj
                  echo $dir
                  return
              end

              set dir (__bobthefish_dirname $dir)
          end
      end

      functions -c __bobthefish_prompt_git __bobthefish_prompt_git_git
      function __bobthefish_prompt_git -S -a git_root_dir -a real_pwd -d 'Display jj or git state'
          if not test -d $git_root_dir/.jj
              __bobthefish_prompt_git_git $git_root_dir $real_pwd
              return
          end

          __bobthefish_path_segment $git_root_dir project

          __bobthefish_start_segment $color_repo
          echo -ns jj ' '
          set_color normal

          set -l project_pwd (__bobthefish_project_pwd $git_root_dir $real_pwd)
          if [ "$project_pwd" ]
              if [ -w "$real_pwd" ]
                  __bobthefish_start_segment $color_path
              else
                  __bobthefish_start_segment $color_path_nowrite
              end

              echo -ns $project_pwd ' '
          end
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
