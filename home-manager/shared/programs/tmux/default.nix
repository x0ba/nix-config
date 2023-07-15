{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: let
  theme = config.colorScheme;
in {
  programs.tmux = {
    enable = true;
    sensibleOnTop = true;
    extraConfig = with theme.colors; ''
      set -g default-terminal "screen-256color"
      set -g prefix `
      unbind C-b
      bind-key `
      set -g status-right-length 100
      set -sg escape-time 0
      unbind %
      unbind z
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
          | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
      bind z if-shell "$is_vim" "send-keys ,z" "resize-pane -Z"
      bind Z resize-pane -Z
      bind h split-window -v
      unbind '"'
      bind v split-window -h
      set -g mouse on
      set -g status-left-length 100
      set -g status-left " "
      set -g status-right " "
      set -g status-justify left
      set -g status-style fg=black,bg=default
      set -g window-status-current-format "#[fg=#${base00},bg=#${base0C}] #I #[fg=#${base05},bg=#${base01}] [#W] #[fg=#${base03},bg=#${base01}]#{s|$HOME|~|;s|.*/||:pane_current_path} "
      set -g window-status-format "#[fg=#{base00},bg=#{base0F}] #I #[fg=#{base04},bg=#{base01}] [#W] #[fg=#{base03},bg=#{base01}]#{s|$HOME|~|;s|.*/||:pane_current_path} "
    '';
  };
}
