local wezterm = require("wezterm")
local c = wezterm.config_builder()

function Scheme_for_appearance(appearance)
  if appearance:find("Dark") then
    return require("rose-pine-wezterm.plugin").main
  else
    return require("rose-pine-wezterm.plugin").dawn
  end
end

require("config.keys").apply(c)

c.default_prog = { "/Users/daniel/.nix-profile/bin/fish", "-l" }

c.font = wezterm.font_with_fallback({
  "SF Mono",
  "Symbols Nerd Font",
})
c.front_end = "WebGpu"
c.font_size = 13
c.command_palette_font_size = c.font_size * 1.1

c.window_decorations = "RESIZE"
c.window_padding = { left = 15, right = 15, top = 15, bottom = 15 }
c.adjust_window_size_when_changing_font_size = false
c.audible_bell = "Disabled"
c.default_cursor_style = "BlinkingBar"
c.inactive_pane_hsb = { brightness = 0.90 }

c.colors = Scheme_for_appearance(wezterm.gui.get_appearance()).colors()
c.window_frame = Scheme_for_appearance(wezterm.gui.get_appearance()).window_frame()

c.enable_tab_bar = true
c.use_fancy_tab_bar = true
c.hide_tab_bar_if_only_one_tab = false
c.show_tab_index_in_tab_bar = true

return c
