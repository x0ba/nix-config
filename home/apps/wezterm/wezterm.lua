local wezterm = require("wezterm")
local c = wezterm.config_builder()
local colors = require("rose-pine/lua/rose-pine").colors()
local window_frame = require("rose-pine/lua/rose-pine").window_frame()
require("config.keys").apply(c)

c.font = wezterm.font_with_fallback({
  "Cascadia Code",
  "Symbols Nerd Font",
})

c.front_end = "WebGpu"
c.line_height = 1.2
c.font_size = 15
c.harfbuzz_features = { "calt=1", "ss01=1" }
c.command_palette_font_size = c.font_size * 1.1
c.window_frame = {
  font = wezterm.font("IBM Plex Sans"),
  font_size = c.font_size,
}

c.colors = colors
c.window_frame = window_frame

c.window_decorations = "RESIZE"
c.window_padding = { left = 25, right = 25, top = 25, bottom = 25 }
c.adjust_window_size_when_changing_font_size = false
c.audible_bell = "Disabled"
c.default_cursor_style = "SteadyBlock"
c.inactive_pane_hsb = { brightness = 0.90 }
c.use_fancy_tab_bar = true
c.hide_tab_bar_if_only_one_tab = true

-- require("bar.plugin").apply_to_config(c)
-- require("catppuccin.plugin").apply_to_config(c, {
--   sync = true,
--   sync_flavors = { dark = "mocha" },
-- })

return c
