---@type wezterm
local wezterm = require("wezterm")
local c = wezterm.config_builder()

require("keys").apply(c)

c.font = wezterm.font_with_fallback({
  "Victor Mono",
  "Symbols Nerd Font",
})
c.font_size = 16.0
c.line_height = 1.1
-- window
c.window_decorations = "RESIZE"
c.window_padding = { left = 25, right = 25, top = 25, bottom = 25 }
-- dim unfocused panes
c.inactive_pane_hsb = {
  saturation = 1.0,
  brightness = 0.8,
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
c.animation_fps = 10

c.color_scheme = "Oxocarbon Dark"
wezterm.plugin.require("https://github.com/nekowinston/wezterm-bar").apply_to_config(c, {
  position = "bottom",
  max_width = 32,
  dividers = "slant_right", -- or "slant_left", "arrows", "rounded", false
  indicator = {
    leader = {
      enabled = true,
      off = " ",
      on = " ",
    },
    mode = {
      enabled = true,
      names = {
        resize_mode = "RESIZE",
        copy_mode = "VISUAL",
        search_mode = "SEARCH",
      },
    },
  },
  tabs = {
    numerals = "arabic",        -- or "roman"
    pane_count = "superscript", -- or "subscript", false
    brackets = {
      active = { "", ":" },
      inactive = { "", ":" },
    },
  },
  clock = {            -- note that this overrides the whole set_right_status
    enabled = true,
    format = "%H:%M ", -- use https://wezfurlong.org/wezterm/config/lua/wezterm.time/Time/format.html
  },
})

return c
