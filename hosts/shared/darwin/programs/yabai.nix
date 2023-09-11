{config, ...}: {
  services.yabai = {
    enable = true;
    enableScriptingAddition = true;
    logFile = "/var/tmp/yabai.log";
    config = {
      # layout
      layout = "bsp";
      auto_balance = "off";
      split_ratio = "0.50";
      window_origin_display = "default";
      window_placement = "second_child";
      window_gap = 07;
      top_padding = 07;
      bottom_padding = 07;
      left_padding = 07;
      right_padding = 07;
      window_shadow = "off";
      window_border = "off";
      window_border_blur = "on";
      window_border_width = 2;
      normal_window_border_color = "0xff262626";
      active_window_border_color = "0xff78a9ff";
      window_border_radius = 11;
      window_border_hidpi = "true";
      mouse_follows_focus = "off";
      focus_follows_mouse = "autofocus";
      window_opacity = "off";
      mouse_action1 = "move";
      mouse_action2 = "resize";
      mouse_drop_action = "swap";
    };
    extraConfig = let
      rule = "yabai -m rule --add";
      ignored = app: builtins.concatStringsSep "\n" (map (e: ''${rule} app="${e}" manage=off sticky=off layer=above border=off'') app);
      unmanaged = app: builtins.concatStringsSep "\n" (map (e: ''${rule} app="${e}" manage=off'') app);
    in ''
      # auto-inject scripting additions
      yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"
      sudo yabai --load-sa

      ${ignored ["JetBrains Toolbox" "Mullvad VPN" "Sip" "iStat Menus"]}
      ${unmanaged ["GOG Galaxy" "Steam" "System Settings"]}
      yabai -m rule --add label="Finder" app="^Finder$" title="(Co(py|nnect)|Move|Info|Pref)" manage=off
      yabai -m rule --add label="Safari" app="^Safari$" title="^(General|(Tab|Password|Website|Extension)s|AutoFill|Se(arch|curity)|Privacy|Advance)$" manage=off

      # etc.
      ${rule} manage=off border=off app="Shottr"
      ${rule} manage=off sticky=on  app="OBS Studio"
    '';
  };
}
