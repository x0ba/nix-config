---@type wezterm
local wezterm = require("wezterm")
local c = wezterm.config_builder()
require("keys").apply(c)

c.font = wezterm.font_with_fallback({
  "Iosevka Nerd Font",
  "Symbols Nerd Font",
})
c.font_size = 17

c.line_height = 1.1

c.bold_brightens_ansi_colors = true

c.hide_tab_bar_if_only_one_tab = true

-- window
c.window_decorations = "RESIZE"
c.window_padding = { left = 37, right = 37, top = 37, bottom = 37 }
c.default_cursor_style = "SteadyUnderline"

-- Tab Bar
c.use_fancy_tab_bar = false

-- dim unfocused panes
c.inactive_pane_hsb = {
  saturation = 1.0,
  brightness = 0.8,
}
-- etc.
c.adjust_window_size_when_changing_font_size = false
c.audible_bell = "Disabled"
c.clean_exit_codes = { 130 }
c.default_cursor_style = "BlinkingBar"
c.launch_menu = {
  { label = "Music player", args = { "ncmpcpp" } },
}
c.command_palette_font_size = 13.0
c.window_frame = { font_size = 13.0 }
c.window_background_opacity = 1.0

c.color_scheme = "Oxocarbon Dark"

return c
