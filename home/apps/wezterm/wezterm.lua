local wezterm = require("wezterm")
local c = wezterm.config_builder()
require("config.keys").apply(c)

c.font = wezterm.font_with_fallback({
  "Cascadia Code",
  "Symbols Nerd Font",
})
c.font_size = 13
c.harfbuzz_features = { "calt=1", "ss01=1" }
c.command_palette_font_size = c.font_size * 1.1
c.front_end = "WebGpu"
c.window_frame = {
  font = wezterm.font("IBM Plex Sans"),
  font_size = c.font_size,
}
c.line_height = 1.2
c.font_size = 15.0
c.window_decorations = "RESIZE"
c.window_padding = { left = 28, right = 28, top = 28, bottom = 28 }
c.inactive_pane_hsb = { brightness = 0.90 }
c.adjust_window_size_when_changing_font_size = false
c.audible_bell = "Disabled"
c.default_cursor_style = "BlinkingBar"

require("bar.plugin").apply_to_config(c)
require("catppuccin.plugin").apply_to_config(c, {
  sync = true,
})

return c
