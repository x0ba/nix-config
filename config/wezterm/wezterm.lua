---@type wezterm
local wezterm = require("wezterm")
local c = wezterm.config_builder()
local custom = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
custom.background = "#000000"
custom.tab_bar.background = "#040404"
custom.tab_bar.inactive_tab.bg_color = "#0f0f0f"
custom.tab_bar.new_tab.bg_color = "#080808"

require("keys").apply(c)

c.font = wezterm.font_with_fallback({
	"Rec Mono Duotone",
	"Symbols Nerd Font",
})
c.font_size = 16
c.line_height = 1.2

-- font rendering
c.freetype_load_flags = "NO_HINTING"
c.freetype_load_target = "Normal"

-- window
c.window_decorations = "RESIZE"
c.window_padding = { left = 45, right = 45, top = 45, bottom = 45 }

c.color_schemes = {
	["OLEDppuccin"] = custom,
}

c.hide_tab_bar_if_only_one_tab = true

-- dim unfocused panes
c.inactive_pane_hsb = {
	brightness = 0.8,
	saturation = 1.0,
}
-- etc.
c.adjust_window_size_when_changing_font_size = false
c.audible_bell = "Disabled"
c.clean_exit_codes = { 130 }
c.default_cursor_style = "SteadyUnderline"
c.launch_menu = {
	{ label = "Music player", args = { "ncmpcpp" } },
}
c.command_palette_font_size = 13.0
c.window_frame = { font_size = 13.0 }
c.window_background_opacity = 1.0

c.color_scheme = "OLEDppuccin"

-- wezterm.plugin.require("https://github.com/nekowinston/wezterm-bar").apply_to_config(c, {})

return c
