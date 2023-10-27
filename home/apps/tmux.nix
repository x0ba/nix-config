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
      set -g status-position bottom
      set -g status-interval 5
      set -g @emulate-scroll-for-no-mouse-alternate-buffer on

      set -g status-justify centre
      set -g status-left "#[fg=black,bg=green]   #[fg=green,bg=red]#{prefix_highlight}#[bg=default]"
      set -g window-status-format "#[fg=magenta,bg=brightblack] #I:#W #[bg=default,fg=black]"
      set -g window-status-current-format "#[bg=magenta,fg=black] #I:#W #[bg=default,fg=black] #[bg=brightblack,fg=red] #S #[bg=red,fg=black]   "
      set -g status-right "#[bg=brightblack,fg=green] %I:%M %p #[fg=green,bg=black]█"

      set -g status-bg default
      set -g status-fg white
      set -g status-style "fg=white,bg=default"
    '';
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.vim-tmux-navigator;
      }
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-vim 'session'
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-capture-pane-contents 'on'
        '';
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-boot 'on'
          set -g @continuum-save-interval '10'
        '';
      }
    ];
  };
}
