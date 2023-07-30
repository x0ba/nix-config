{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: let
  scripts = ../../../../config/sketchybar;
in {
  services.yabai = {
    enable = true;
    enableScriptingAddition = true;
    package = pkgs.yabai;
    config = {
      # layout
      layout = "bsp";
      auto_balance = "off";
      split_ratio = "0.50";
      window_placement = "second_child";
      # external_bar = "all:40:0";
      # Gaps
      window_gap = 06;
      top_padding = 12;
      bottom_padding = 12;
      left_padding = 12;
      right_padding = 12;
      # shadows and borders
      window_shadow = "float";
      active_window_border_color = "0xffb4befe";
      normal_window_border_color = "0xff161616";
      window_border_radius = 11;
      window_border_blur = "off";
      window_border_width = 02;
      window_border_hidpi = "true";
      window_border = "off";
      # mouse
      mouse_follows_focus = "off";
      focus_follows_mouse = "on";
      window_opacity = "off";
      mouse_modifier = "fn";
      mouse_action1 = "move";
      mouse_action2 = "resize";
      mouse_drop_action = "swap";
    };
    extraConfig = ''
      # Unload the macOS WindowManager process
      launchctl unload -F /System/Library/LaunchAgents/com.apple.WindowManager.plist > /dev/null 2>&1 &
      # bar
      # Automatically focus window under mouse after closing
      yabai -m signal --add event=window_focused action="sketchybar --trigger window_focus"
      yabai -m signal --add event=window_created action="sketchybar --trigger windows_on_spaces"
      yabai -m signal --add event=window_destroyed action="sketchybar --trigger windows_on_spaces"
      yabai -m signal --add event=window_destroyed action="yabai -m query --windows --window &> /dev/null || yabai -m window --focus mouse"
      yabai -m signal --add event=application_terminated action="yabai -m query --windows --window &> /dev/null || yabai -m window --focus mouse"
      # rules
      yabai -m rule --add app="^(LuLu|Calculator|Software Update|Dictionary|VLC|System Preferences|System Settings|zoom.us|Photo Booth|Archive Utility|Python|LibreOffice|App Store|Steam|Alfred|Activity Monitor)$" manage=off
      yabai -m rule --add label="Finder" app="^Finder$" title="(Co(py|nnect)|Move|Info|Pref)" manage=off
      yabai -m rule --add label="Safari" app="^Safari$" title="^(General|(Tab|Password|Website|Extension)s|AutoFill|Se(arch|curity)|Privacy|Advance)$" manage=off
      yabai -m rule --add label="About This Mac" app="System Information" title="About This Mac" manage=off
      yabai -m rule --add label="Select file to save to" app="^Inkscape$" title="Select file to save to" manage=off
    '';
  };
}
