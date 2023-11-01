local wezterm = require("wezterm")
local c = wezterm.config_builder()
local oledppuccin = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
oledppuccin.background = "#000000"
oledppuccin.tab_bar.background = "#040404"
oledppuccin.tab_bar.inactive_tab.bg_color = "#0f0f0f"
oledppuccin.tab_bar.new_tab.bg_color = "#080808"
oledppuccin.ansi[6] = "#c6a0f6"

require("keys").apply(c)

c.font =
  wezterm.font_with_fallback({ "Liga Berkeley Mono", "Symbols Nerd Font" })
c.line_height = 1.2
c.font_size = 15.0
c.window_decorations = "RESIZE"
c.window_padding = { left = 28, right = 28, top = 28, bottom = 28 }
c.inactive_pane_hsb = { saturation = 1.0, brightness = 0.8 }
c.adjust_window_size_when_changing_font_size = false
c.audible_bell = "Disabled"
c.clean_exit_codes = { 130 }
c.default_cursor_style = "BlinkingBar"
c.command_palette_font_size = 13.0
c.window_frame = { font_size = 13.0 }

c.color_schemes = {
  ["OLEDppuccin"] = oledppuccin,
}

c.color_scheme = "OLEDppuccin"

wezterm.plugin
  .require("https://github.com/nekowinston/wezterm-bar")
  .apply_to_config(c)

return c
