local wezterm = require("wezterm")
local c = wezterm.config_builder()
require("config.keys").apply(c)

c.font = wezterm.font_with_fallback({
  "Liga Berkeley Mono",
  "Symbols Nerd Font",
})
c.front_end = "WebGpu"
c.font_size = 15
c.line_height = 1.2
c.command_palette_font_size = c.font_size * 1.1
c.window_frame = {
  font = wezterm.font("Overpass"),
  font_size = c.font_size,
}

c.window_decorations = "RESIZE"
c.window_padding = { left = 35, right = 35, top = 35, bottom = 35 }
c.adjust_window_size_when_changing_font_size = false
c.audible_bell = "Disabled"
c.default_cursor_style = "BlinkingBar"
c.inactive_pane_hsb = { brightness = 0.90 }
c.hide_tab_bar_if_only_one_tab = false
c.use_fancy_tab_bar = false
c.color_scheme = "tokyonight_night"
require("bar.plugin").apply_to_config(c)

return c
