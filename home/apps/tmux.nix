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
    '';
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.vim-tmux-navigator;
      }
    ];
  };
}
