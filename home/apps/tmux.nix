{
  pkgs,
  config,
  ...
}: {
  programs.tmux = {
    enable = true;
    sensibleOnTop = true;
    extraConfig = with config.lib.stylix.colors; ''
      set -g history-file "~/.cache/tmux/.tmuxhistory"
      set -g repeat-time 700
      set -g mouse on
      set -g status on
      set -g focus-events on
      set -g automatic-rename on
      set -g renumber-windows on
      set -g monitor-activity on
      set -g visual-activity off
      set -g bell-action none
      set -g mode-keys vi
      set -g status-keys vi
      set -g base-index 1
      set -g pane-base-index 1
      set -g escape-time 0
      set -g history-limit 10000
      set -g pane-border-style "bg=default,fg=black"
      set -g pane-active-border-style "bg=default,fg=green"


      set-option -sa terminal-features ",alacritty:RGB"
      set -g default-terminal "screen-256color"
      bind-key R source-file "~/.config/tmux/tmux.conf" \; display-message "Reloaded configurations!"
      bind-key B set status

      set -g prefix C-a
      unbind C-b
      bind-key C-a send-prefix
      set -g detach-on-destroy off

      unbind-key up
      unbind-key down
      unbind-key left
      unbind-key t
      unbind-key up
      unbind-key x
      unbind-key <
      unbind-key >

      bind -T copy-mode-vi v send -X begin-selection
      bind-key C-o display-popup -E "tms"
      bind-key C-j display-popup -E "tms switch"
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "pbcopy"
      bind P paste-buffer
      bind -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "pbcopy"

      unbind %
      bind-key - split-window -v
      unbind '"'
      bind-key | split-window -h

      bind-key x kill-pane
      bind-key & kill-window
      bind-key t run-shell "t"

      bind-key > swap-pane -D
      bind-key < swap-pane -U

      bind -r j resize-pane -D 5
      bind -r k resize-pane -U 5
      bind -r l resize-pane -R 5
      bind -r h resize-pane -L 5
      bind -r m resize-pane -Z

      set -g mode-style "bg=default,fg=default"
      set -g status-interval 5
      set -g @emulate-scroll-for-no-mouse-alternate-buffer on

      set -g status-left "#[fg=blue,bold,bg=#1e1e2e]  #S  "
      set -g status-right "#[fg=#b4befe,bold,bg=#1e1e2e]%a %Y-%m-%d 󱑒 %l:%M %p"
      set -ga status-right "#($HOME/.config/tmux/scripts/cal.sh)"
      set -g status-justify left
      set -g status-left-length 200    # increase length (from 10)
      set -g status-right-length 200    # increase length (from 10)
      set -g status-position top       # macOS / darwin style
      set -g status-style 'bg=#1e1e2e' # transparent
      set -g window-status-current-format '#[fg=magenta,bg=#1e1e2e]*#I #W#{?window_zoomed_flag,(),} '
      set -g window-status-format '#[fg=gray,bg=#1e1e2e] #I #W'
      set -g window-status-last-style 'fg=white,bg=black'
      set -g default-terminal "''${TERM}"
      set -g message-command-style bg=default,fg=yellow
      set -g message-style bg=default,fg=yellow
      set -g mode-style bg=default,fg=yellow
    '';
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.vim-tmux-navigator;
      }
    ];
  };
}
