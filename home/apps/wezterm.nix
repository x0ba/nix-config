{
  config,
  flakePath,
  ...
}: {
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wez = require('wezterm')
      return {
        default_prog     = { 'zsh' },
        -- Performance
        --------------
        front_end        = "WebGpu",
        scrollback_lines = 1024,
        -- Fonts
        --------
        bold_brightens_ansi_colors = true,
        font_rules    = {
          {
            italic = true,
            font   = wez.font("IBM Plex Mono", { italic = true })
          }
        },
        font_size         = 14.0,
        line_height       = 1.2,
        harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' },
        -- Bling
        --------
        window_padding = {
          left = "24pt", right = "24pt",
          bottom = "24pt", top = "24pt"
        },
        default_cursor_style = "SteadyBar",
        window_decorations = "RESIZE",
        enable_scroll_bar    = false,
        warn_about_missing_glyphs = false,
        -- Tabbar
        ---------
        enable_tab_bar               = true,
        use_fancy_tab_bar            = true,
        hide_tab_bar_if_only_one_tab = true,
        show_tab_index_in_tab_bar    = false,
        -- Miscelaneous
        ---------------
        window_close_confirmation = "NeverPrompt",
        inactive_pane_hsb         = {
          saturation = 1.0, brightness = 0.8
        },
        check_for_updates = false,
      }
    '';
  };
  # # disable the default config created by Home-Manager
  # xdg.configFile."wezterm/wezterm.lua".enable = false;
  # # and use my own config instead
  # xdg.configFile."wezterm" = {
  #   source = config.lib.file.mkOutOfStoreSymlink "${flakePath}/home/apps/wezterm";
  #   recursive = true;
  # };
  programs.zsh.initExtra = ''
    if [[ "$TERM_PROGRAM" == "WezTerm" ]]; then
      TERM=wezterm
      source ${config.programs.wezterm.package}/etc/profile.d/wezterm.sh
    fi
  '';
}
