{
  config,
  pkgs,
  ...
}: {
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wez = require('wezterm')
      local c = wezterm.config_builder()
      require("keys").apply(c)
      return {
        default_prog     = { '${pkgs.zsh}/bin/zsh' },
        -- Performance
        --------------
        front_end        = "WebGpu",
        scrollback_lines = 1024,
        -- Fonts
        --------
        bold_brightens_ansi_colors = true,
        keys = {
          {
            key = 'p',
            mods = 'SHIFT|CMD', action = wezterm.action.ActivateCommandPalette, },
        },
        font_rules    = {
          {
            italic = true,
            font   = wez.font("Maple Mono", { italic = true })
          }
        },
        command_palette_font_size = 14.0,
        font_size         = 15.0,
        line_height       = 1.2,
        harfbuzz_features = { 'ss14', 'calt=1', 'clig=1', 'liga=1' },
        -- Bling
        --------
        window_padding = {
          left = "24pt", right = "24pt",
          bottom = "24pt", top = "24pt"
        },
        default_cursor_style = "BlinkingBar",
        window_decorations = "RESIZE",
        enable_scroll_bar    = false,
        warn_about_missing_glyphs = false,
        -- Tabbar
        ---------
        enable_tab_bar               = true,
        use_fancy_tab_bar            = false,
        hide_tab_bar_if_only_one_tab = true,
        show_tab_index_in_tab_bar    = true,
        -- Miscelaneous
        ---------------
        window_close_confirmation = "NeverPrompt",
        inactive_pane_hsb         = {
          saturation = 1.0, brightness = 0.8
        },
        check_for_updates = false,
      }
    '';
  };
  xdg.configFile."wezterm/keys.lua".text = ''
    local wezterm = require("wezterm")
    local act = wezterm.action

    local shortcuts = {}

    local map = function(key, mods, action)
      if type(mods) == "string" then
        table.insert(shortcuts, { key = key, mods = mods, action = action })
      elseif type(mods) == "table" then
        for _, mod in pairs(mods) do
          table.insert(shortcuts, { key = key, mods = mod, action = action })
        end
      end
    end

    wezterm.GLOBAL.enable_tab_bar = true
    local toggleTabBar = wezterm.action_callback(function(window)
      wezterm.GLOBAL.enable_tab_bar = not wezterm.GLOBAL.enable_tab_bar
      window:set_config_overrides({
        enable_tab_bar = wezterm.GLOBAL.enable_tab_bar,
      })
    end)

    local openUrl = act.QuickSelectArgs({
      label = "open url",
      patterns = { "https?://\\S+" },
      action = wezterm.action_callback(function(window, pane)
        local url = window:get_selection_text_for_pane(pane)
        wezterm.open_with(url)
      end),
    })

    -- use 'Backslash' to split horizontally
    map("\\", "LEADER", act.SplitHorizontal({ domain = "CurrentPaneDomain" }))
    -- and 'Minus' to split vertically
    map("-", "LEADER", act.SplitVertical({ domain = "CurrentPaneDomain" }))
    -- map 1-9 to switch to tab 1-9, 0 for the last tab
    for i = 1, 9 do
      map(tostring(i), { "LEADER", "SUPER" }, act.ActivateTab(i - 1))
    end
    map("0", { "LEADER", "SUPER" }, act.ActivateTab(-1))
    -- 'hjkl' to move between panes
    map("h", { "LEADER", "SUPER" }, act.ActivatePaneDirection("Left"))
    map("j", { "LEADER", "SUPER" }, act.ActivatePaneDirection("Down"))
    map("k", { "LEADER", "SUPER" }, act.ActivatePaneDirection("Up"))
    map("l", { "LEADER", "SUPER" }, act.ActivatePaneDirection("Right"))
    -- resize
    map("h", "LEADER|SHIFT", act.AdjustPaneSize({ "Left", 5 }))
    map("j", "LEADER|SHIFT", act.AdjustPaneSize({ "Down", 5 }))
    map("k", "LEADER|SHIFT", act.AdjustPaneSize({ "Up", 5 }))
    map("l", "LEADER|SHIFT", act.AdjustPaneSize({ "Right", 5 }))
    -- spawn & close
    map("c", "LEADER", act.SpawnTab("CurrentPaneDomain"))
    map("x", "LEADER", act.CloseCurrentPane({ confirm = true }))
    map("t", { "SHIFT|CTRL", "SUPER" }, act.SpawnTab("CurrentPaneDomain"))
    map("w", { "SHIFT|CTRL", "SUPER" }, act.CloseCurrentTab({ confirm = true }))
    map("n", { "SHIFT|CTRL", "SUPER" }, act.SpawnWindow)
    -- zoom states
    map("z", { "LEADER", "SUPER" }, act.TogglePaneZoomState)
    map("Z", { "LEADER", "SUPER" }, toggleTabBar)
    -- copy & paste
    map("v", "LEADER", act.ActivateCopyMode)
    map("c", { "SHIFT|CTRL", "SUPER" }, act.CopyTo("Clipboard"))
    map("v", { "SHIFT|CTRL", "SUPER" }, act.PasteFrom("Clipboard"))
    map("f", { "SHIFT|CTRL", "SUPER" }, act.Search("CurrentSelectionOrEmptyString"))
    -- rotation
    map("e", { "LEADER", "SUPER" }, act.RotatePanes("Clockwise"))
    -- pickers
    map(" ", "LEADER", act.QuickSelect)
    map("o", { "LEADER", "SUPER" }, openUrl)
    map("p", { "LEADER", "SUPER" }, act.PaneSelect({ alphabet = "asdfghjkl;" }))
    map("R", { "LEADER", "SUPER" }, act.ReloadConfiguration)
    map("u", "SHIFT|CTRL", act.CharSelect)
    map("p", { "SHIFT|CTRL", "SHIFT|SUPER" }, act.ActivateCommandPalette)
    -- view
    map("Enter", "ALT", act.ToggleFullScreen)
    map("-", { "CTRL", "SUPER" }, act.DecreaseFontSize)
    map("=", { "CTRL", "SUPER" }, act.IncreaseFontSize)
    map("0", { "CTRL", "SUPER" }, act.ResetFontSize)
    -- switch fonts
    map("f", "LEADER", act.EmitEvent("switch-font"))
    -- debug
    map("l", "SHIFT|CTRL", act.ShowDebugOverlay)

    map(
      "r",
      { "LEADER", "SUPER" },
      act.ActivateKeyTable({
        name = "resize_mode",
        one_shot = false,
      })
    )

    local key_tables = {
      resize_mode = {
        { key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
        { key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },
        { key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
        { key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
        { key = "LeftArrow", action = act.AdjustPaneSize({ "Left", 1 }) },
        { key = "DownArrow", action = act.AdjustPaneSize({ "Down", 1 }) },
        { key = "UpArrow", action = act.AdjustPaneSize({ "Up", 1 }) },
        { key = "RightArrow", action = act.AdjustPaneSize({ "Right", 1 }) },
      },
    }

    -- add a common escape sequence to all key tables
    for k, _ in pairs(key_tables) do
      table.insert(key_tables[k], { key = "Escape", action = "PopKeyTable" })
      table.insert(key_tables[k], { key = "Enter", action = "PopKeyTable" })
      table.insert(
        key_tables[k],
        { key = "c", mods = "CTRL", action = "PopKeyTable" }
      )
    end

    local M = {}
    M.apply = function(c)
      c.leader = {
        key = "s",
        mods = "CTRL",
        timeout_milliseconds = math.maxinteger,
      }
      c.keys = shortcuts
      c.disable_default_key_bindings = true
      c.key_tables = key_tables
      c.mouse_bindings = {
        {
          event = { Down = { streak = 1, button = { WheelUp = 1 } } },
          mods = "NONE",
          action = wezterm.action.ScrollByLine(5),
        },
        {
          event = { Down = { streak = 1, button = { WheelDown = 1 } } },
          mods = "NONE",
          action = wezterm.action.ScrollByLine(-5),
        },
      }
    end
    return M
  '';
  programs.zsh.initExtra = ''
    if [[ "$TERM_PROGRAM" == "WezTerm" ]]; then
      TERM=wezterm
      source ${config.programs.wezterm.package}/etc/profile.d/wezterm.sh
    fi
  '';
}
