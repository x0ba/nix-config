{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    tmux.enable = lib.mkEnableOption "enables tmux";
  };

  config = lib.mkIf config.tmux.enable {
    programs.tmux = {
      enable = true;
      sensibleOnTop = true;
      catppuccin = {
        enable = true;
        extraConfig = ''
          set -g @catppuccin_window_left_separator ""
          set -g @catppuccin_window_right_separator " "
          set -g @catppuccin_window_middle_separator " █"
          set -g @catppuccin_window_number_position "right"

          set -g @catppuccin_window_default_fill "number"
          set -g @catppuccin_window_default_text "#W"

          set -g @catppuccin_window_current_fill "number"
          set -g @catppuccin_window_current_text "#W"

          set -g @catppuccin_status_modules_right "directory session"
          set -g @catppuccin_status_left_separator  " "
          set -g @catppuccin_status_right_separator ""
          set -g @catppuccin_status_fill "icon"
          set -g @catppuccin_status_connect_separator "no"

          set -g @catppuccin_directory_text "#{pane_current_path}"
        '';
      };
      prefix = "C-s";
      plugins = with pkgs.tmuxPlugins; [
        {
          plugin = jump;
          extraConfig = "set -g @jump-key 'f'";
        }
        { plugin = vim-tmux-navigator; }
        {
          plugin = open;
          extraConfig = "set -g @open-S 'https://duckduckgo.com/?q='";
        }
        {
          plugin = urlview;
          extraConfig = "set -g @urlview-key 'u'";
        }
      ];
      terminal = "tmux-256color";

      baseIndex = 1;
      clock24 = true;
      mouse = true;

      keyMode = "vi";
      customPaneNavigationAndResize = true;

      extraConfig = ''
        unbind r
        bind r source-file ~/.config/tmux/tmux.conf

        set-option -g focus-events on
        set-option -sg escape-time 10

        bind-key h select-pane -L
        bind-key j select-pane -D
        bind-key k select-pane -U
        bind-key l select-pane -R

        bind-key x kill-pane
        set -g detach-on-destroy off

        unbind-key \\
        unbind-key -
        bind-key \\ split-window -h -c "#{pane_current_path}"
        bind-key -  split-window -v -c "#{pane_current_path}"

        set-option -g status-position top

        bind-key "k" run-shell "sesh connect \"$(
          sesh list | fzf-tmux -p 55%,60% \
            --no-sort --ansi --border-label ' sesh ' --prompt '⚡  ' \
            --header '  ^a all ^t tmux ^g configs ^x zoxide ^d tmux kill ^f find' \
            --bind 'tab:down,btab:up' \
            --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list)' \
            --bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list -t)' \
            --bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list -c)' \
            --bind 'ctrl-x:change-prompt(📁  )+reload(sesh list -z)' \
            --bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
            --bind 'ctrl-d:execute(tmux kill-session -t {})+change-prompt(⚡  )+reload(sesh list)'
        )\""
      '';
    };
  };
}
