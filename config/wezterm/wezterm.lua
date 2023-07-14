---@type wezterm
local wezterm = require("wezterm")
local c = wezterm.config_builder()

require("keys").apply(c)

c.font = wezterm.font_with_fallback({
	"Maple Mono SC NF",
	"JetBrainsMono Nerd Font",
})
-- window
c.window_decorations = "RESIZE"
c.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
-- dim unfocused panes
c.inactive_pane_hsb = {
	saturation = 1.0,
	brightness = 0.8,
}
c.front_end = "WebGpu"
-- etc.
c.adjust_window_size_when_changing_font_size = false
c.animation_fps = 1

c.window_padding = {
	left = 25,
	right = 25,
	top = 25,
	bottom = 25,
}
c.audible_bell = "Disabled"
c.clean_exit_codes = { 130 }
c.default_cursor_style = "BlinkingBar"
c.launch_menu = {
	{ label = "Music player", args = { "ncmpcpp" } },
}
c.command_palette_font_size = 13.0
c.window_frame = { font_size = 13.0 }
c.font_size = 15
c.window_background_opacity = 1.0
c.color_scheme = "Oxocarbon Dark"

wezterm.plugin.require("https://github.com/nekowinston/wezterm-bar").apply_to_config(c)

return c
