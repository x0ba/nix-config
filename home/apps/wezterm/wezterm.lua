local wezterm = require("wezterm")
local c = wezterm.config_builder()
require("config.keys").apply(c)

c.font = wezterm.font_with_fallback({
  "Liga Berkeley Mono",
  "Symbols Nerd Font",
})

c.front_end = "WebGpu"
c.line_height = 1.1
c.font_size = 15
c.harfbuzz_features = { "calt=1", "ss01=1" }
c.command_palette_font_size = c.font_size * 1.1
c.window_frame = {
  font = wezterm.font("IBM Plex Sans"),
  font_size = c.font_size,
}

c.window_decorations = "RESIZE"
c.window_padding = { left = 20, right = 20, top = 20, bottom = 20 }
c.adjust_window_size_when_changing_font_size = false
c.audible_bell = "Disabled"
c.default_cursor_style = "BlinkingBar"
c.inactive_pane_hsb = { brightness = 0.90 }
c.use_fancy_tab_bar = false

require("bar.plugin").apply_to_config(c)
require("catppuccin.plugin").apply_to_config(c, {
  sync = true,
  sync_flavors = { dark = "mocha" },
})

return c
