{ config
, pkgs
, ...
}: {
  programs.wezterm = {
    enable = true;
    package = pkgs.nur.repos.nekowinston.wezterm-nightly;
    extraConfig = ''
      local wezterm = require("wezterm")

      return {
      	-- Font
        font = wezterm.font_with_fallback { 'IBM Plex Mono', 'Symbols Nerd Font' },
        bold_brightens_ansi_colors = true,
      	-- Font size
      	font_size = 16.0,
      	line_height = 1.15,

      	-- window
      	window_decorations = "RESIZE",
        window_padding = {
          left = "24pt", right = "24pt",
          bottom = "24pt", top = "24pt"
        },
      	hide_tab_bar_if_only_one_tab = true,

        default_cursor_style = "SteadyUnderline",

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

      	-- Tab Colors
      	colors = {
      		indexed = { [16] = "#f1cf8a", [17] = "#dee1e6" },

      		scrollbar_thumb = "#384148",
      		split = "#22262e",

      		tab_bar = {
      			background = "#22262e",
      			active_tab = {
      				bg_color = "#70a5eb",
      				fg_color = "#fafdff",
      			},
      			inactive_tab = {
      				bg_color = "#22262e",
      				fg_color = "#fafdff",
      			},
      			inactive_tab_hover = {
      				bg_color = "#384148",
      				fg_color = "#fafdff",
      			},
      			new_tab = {
      				bg_color = "#22262e",
      				fg_color = "#fafdff",
      			},
      			new_tab_hover = {
      				bg_color = "#384148",
      				fg_color = "#fafdff",
      				italic = true,
      			},
      		},

      		visual_bell = "#384148",

      		-- nightbuild only
      		compose_cursor = "#f1cf8a",

      		-- Theme Colors (Decay)
      		foreground = "#b6beca",
      		background = "#171a1f",
      		cursor_bg = "#dee1e6",
      		cursor_border = "#fafdff",
      		cursor_fg = "#22262e",
      		selection_bg = "#575268",
      		selection_fg = "#D9E0EE",

      		ansi = { "#1c252c", "#e05f65", "#78dba9", "#f1cf8a", "#70a5eb", "#c68aee", "#74bee9", "#dee1e6" },
      		brights = { "#384148", "#fc7b81", "#94f7c5", "#ffeba6", "#8cc1ff", "#e2a6ff", "#90daff", "#fafdff" },
      	},
      }
    '';
  };
  # disable the default config created by Home-Manager
  # xdg.configFile."wezterm/wezterm.lua".enable = false;
  # and use my own config instead
  # xdg.configFile."wezterm" = {
  #   source = config.lib.file.mkOutOfStoreSymlink "${flakePath}/config/wezterm";
  #   recursive = true;
  # };
  programs.zsh.initExtra = ''
    if [[ "$TERM_PROGRAM" == "WezTerm" ]]; then
      TERM=wezterm
      source ${config.programs.wezterm.package}/etc/profile.d/wezterm.sh
    fi
  '';
}
