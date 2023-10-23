{
  config,
  flakePath,
  pkgs,
  ...
}: {
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wez = require('wezterm')
      return {
        default_prog     = { '${pkgs.zsh}/bin/zsh' },
        -- Performance
        --------------
        front_end        = "WebGpu",
        scrollback_lines = 1024,
        -- Fonts
        --------
        bold_brightens_ansi_colors = true,
        keys = {
          {
            key = 'p',
            mods = 'SHIFT|CMD',
            action = wezterm.action.ActivateCommandPalette,
          },
        },

        font_rules    = {
          {
            italic = true,
            font   = wez.font("IBM Plex Mono", { italic = true })
          }
        },
        command_palette_font_size = 14.0,
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
        use_fancy_tab_bar            = false,
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
  programs.zsh.initExtra = ''
    if [[ "$TERM_PROGRAM" == "WezTerm" ]]; then
      TERM=wezterm
      source ${config.programs.wezterm.package}/etc/profile.d/wezterm.sh
    fi
  '';
}
