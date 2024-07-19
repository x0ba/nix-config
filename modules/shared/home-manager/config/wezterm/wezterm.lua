local wezterm = require("wezterm")
local c = wezterm.config_builder()

require("config.keys").apply(c)

c.font = wezterm.font_with_fallback({
  "Berkeley Mono",
  "Symbols Nerd Font",
})
c.front_end = "WebGpu"
c.font_size = 13
c.command_palette_font_size = c.font_size * 1.1
c.window_frame = {
  font = wezterm.font("IBM Plex Sans"),
}
c.colors = {
  tab_bar = {
    background = "#3c3836",
    active_tab = {
      bg_color = "#282828",
      fg_color = "#EBDbb2",
    },
    inactive_tab = {
      bg_color = "#3c3836",
      fg_color = "#928374",
    },
  },
}
c.color_scheme = "GruvboxDark"

c.window_decorations = "RESIZE|INTEGRATED_BUTTONS"
c.window_padding = { left = 15, right = 15, top = 50, bottom = 15 }
c.adjust_window_size_when_changing_font_size = false
c.audible_bell = "Disabled"
c.default_cursor_style = "BlinkingBar"
c.inactive_pane_hsb = { brightness = 0.90 }

c.tab_bar_at_bottom = true
c.use_fancy_tab_bar = false
c.show_tab_index_in_tab_bar = true

return c
