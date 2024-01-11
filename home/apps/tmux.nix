{pkgs, ...}: let
  t-smart-tmux-session-manager = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "t-smart-tmux-session-manager";
    rtpFilePath = "t-smart-tmux-session-manager.tmux";
    version = "2024-01-02";
    src = pkgs.fetchFromGitHub {
      owner = "joshmedeski";
      repo = "t-smart-tmux-session-manager";
      rev = "3fd8c7bc6220fb7dc661a096f0bf378bc23d6504";
      sha256 = "sha256-DwjUBCyFjvlA1kSiElZKfG2XRyN01+QIopvggN6dkqM=";
    };
  };
  tmux-last = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux-last";
    rtpFilePath = "tmux-last.tmux";
    version = "2024-01-02";
    src = pkgs.fetchFromGitHub {
      owner = "mskelton";
      repo = "tmux-last";
      rev = "4d7e0c1386a9a74803a53b524ac47dd3cd08c0a4";
      sha256 = "sha256-ydWdL2bdHb58F+i1+nwfRqI9T85ez1Cw6YAZIgz/2V4=";
    };
  };
  tmux-nerd-font-window-name = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux-nerd-font-window-name";
    rtpFilePath = "tmux-nerd-font-window-name.tmux";
    version = "2024-01-02";
    src = pkgs.fetchFromGitHub {
      owner = "joshmedeski";
      repo = "tmux-nerd-font-window-name";
      rev = "410d5becb3a5c118d5fabf89e1633d137906caf1";
      sha256 = "sha256-HqSaOcnb4oC0AtS0aags2A5slsPiikccUSuZ1sVuago";
    };
  };
  tmux-fzf-url = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux-fzf-url";
    rtpFilePath = "fzf-url.tmux";
    version = "2024-01-02";
    src = pkgs.fetchFromGitHub {
      owner = "joshmedeski";
      repo = "tmux-fzf-url";
      rev = "3bc7b34c0321d5dfe4a8d2545be23654ad321fc0";
      sha256 = "sha256-aWqwoJ5L3FB6vZKds7Q4AQ/8Pv2zQnPugL/6BpsBlRo=";
    };
  };
in {
  programs.tmux = {
    enable = true;
    extraConfig = ''
      set-option -g focus-events on

      set-option -g display-time 3000

      set -g default-terminal "tmux-256color"
      set -ag terminal-overrides ",xterm-256color:RGB"

      set -g base-index 1          # start indexing windows at 1 instead of 0
      set -g detach-on-destroy off # don't exit from tmux when closing a session
      set -g escape-time 0         # zero-out escape time delay
      set -g history-limit 1000000 # increase history size (from 2,000)
      set -g mouse on              # enable mouse support
      set -g renumber-windows on   # renumber all windows when any window is closed
      set -g set-clipboard on      # use system clipboard
      set -g status-interval 3     # update the status bar every 3 seconds

      set -g status-left "#[fg=blue,bold]#S"
      set -ga status-left " #[fg=white,nobold]#(gitmux -cfg $HOME/.config/tmux/gitmux.yml)"
      set -g status-left-length 200
      set -g status-position top
      set -g status-right ""
      set -g status-style 'bg=default'

      set -g window-status-current-format '👉#[fg=magenta]#W'
      set -g window-status-format '  #[fg=gray]#W'

      set -g allow-passthrough on
      set -ga update-environment TERM
      set -ga update-environment TERM_PROGRAM

      set -g default-terminal "''${TERM}"
      set -g message-command-style bg=default,fg=yellow
      set -g message-style bg=default,fg=yellow
      set -g mode-style bg=default,fg=yellow
      set -g pane-active-border-style 'fg=magenta,bg=default'
      set -g pane-border-style 'fg=brightblack,bg=default'

      bind '%' split-window -c '#{pane_current_path}' -h
      bind '"' split-window -c '#{pane_current_path}'
      bind c new-window -c '#{pane_current_path}'
      # TODO: repeat this for all bindings
      bind -N "⌘+g lazygit " g new-window -c "#{pane_current_path}" -n "" "lazygit 2> /dev/null"
      bind -N "⌘+G gh-dash " G new-window -c "#{pane_current_path}" -n "" "ghd 2> /dev/null"
      bind B new-window -n '👷' b
      bind D new-window -n '👷' d
      bind-key T run-shell "t"
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      bind-key -T copy-mode-vi 'C-h' select-pane -L
      bind-key -T copy-mode-vi 'C-j' select-pane -D
      bind-key -T copy-mode-vi 'C-k' select-pane -U
      bind-key -T copy-mode-vi 'C-l' select-pane -R
      bind-key -T copy-mode-vi 'v' send-keys -X begin-selection
      bind-key x kill-pane # skip "kill-pane 1? (y/n)" prompt (cmd+w)
      bind-key e send-keys "tmux capture-pane -p -S - | nvim -c 'set buftype=nofile' +" Enter
    '';
    plugins = with pkgs; [
      {
        plugin = t-smart-tmux-session-manager;
        extraConfig = ''
          set -g @t-bind 'T'
          set -g @t-fzf-find-binding 'ctrl-f:change-prompt(  )+reload(fd -H -d 2 -t d -E .Trash . ~)'
          set -g @t-fzf-prompt '🔭 '
        '';
      }
      {
        plugin = tmux-fzf-url;
        extraConfig = ''
          set -g @fzf-url-fzf-options '-p 60%,30% --prompt="   " --border-label=" Open URL "'
          set -g @fzf-url-history-limit '2000'
        '';
      }
      {
        plugin = tmux-nerd-font-window-name;
        extraConfig = ''
          set -g @tmux-nerd-font-window-name-shell-icon ''
          set -g @tmux-nerd-font-window-name-show-name false
        '';
      }
      {
        plugin = tmuxPlugins.tmux-thumbs;
        extraConfig = ''
          set -g @thumbs-command 'echo -n {} | pbcopy'
          set -g @thumbs-key C
        '';
      }
      {
        plugin = tmuxPlugins.vim-tmux-navigator;
      }
      {
        plugin = tmux-last;
        extraConfig = ''
          set -g @tmux-last-color on
          set -g @tmux-last-pager 'less -r'
          set -g @tmux-last-pager 'less'
          set -g @tmux-last-prompt-pattern ' '
        '';
      }
    ];
  };
  home.packages = [
    t-smart-tmux-session-manager.src
  ];
  xdg.configFile."tmux/tmux-nerd-font-window-name.yml".text = ''
    config:
      fallback-icon: "❓"
      multi-pane-icon: "🪟"
      show-name: false

    icons:
      btop: "📈"
      bun: "🥟"
      docker: "🐳"
      zsh: ""
      nvim: ""
      overmind: "👀"
      stripe-mock: "💳"
      stripe: "💳"
  '';
  xdg.configFile."tmux/gitmux.yml".text = ''
    tmux:
      symbols:
        branch: " "
        hashprefix: ":"
        ahead: " "
        behind: " "
        staged: " "
        conflict: "󰕚 "
        untracked: "󱀶 "
        modified: " "
        stashed: " "
        clean: " "
        insertions: " "
        deletions: " "
      styles:
        state: "#[fg=red,nobold]"
        branch: "#[fg=white,nobold]"
        staged: "#[fg=green,nobold]"
        conflict: "#[fg=red,nobold]"
        modified: "#[fg=yellow,nobold]"
        untracked: "#[fg=gray,nobold]"
        stashed: "#[fg=gray,nobold]"
        clean: "#[fg=green,nobold]"
        divergence: "#[fg=cyan,nobold]"
      layout: [branch, divergence, flags, stats, " "]
      options:
        branch_max_len: 0
        hide_clean: true
  '';
}
