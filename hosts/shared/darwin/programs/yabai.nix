{ config, ... }: {
  services.yabai = {
    enable = false;
    enableScriptingAddition = true;
    config = {
      # layout
      layout = "bsp";
      auto_balance = "off";
      split_ratio = "0.50";
      window_placement = "second_child";
      # Gaps
      window_gap = 06;
      top_padding = 12;
      bottom_padding = 12;
      left_padding = 12;
      right_padding = 12;
      external_bar = "all:0:40";
      # shadows and borders
      window_shadow = "float";
      active_window_border_color = "0xff262626";
      normal_window_border_color = "0xff191919";
      window_border_radius = 11;
      window_border_blur = "off";
      window_border_width = 03;
      window_border_hidpi = "true";
      window_border = "off";
      # mouse
      mouse_follows_focus = "off";
      focus_follows_mouse = "autofocus";
      window_opacity = "off";
      mouse_modifier = "fn";
      mouse_action1 = "move";
      mouse_action2 = "resize";
      mouse_drop_action = "swap";
    };
    extraConfig =
      let
        rule = "yabai -m rule --add";
        ignored = app: builtins.concatStringsSep "\n" (map (e: ''${rule} app="${e}" manage=off sticky=off layer=above border=off'') app);
        unmanaged = app: builtins.concatStringsSep "\n" (map (e: ''${rule} app="${e}" manage=off'') app);
      in
      ''
        # auto-inject scripting additions
        yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"
        sudo yabai --load-sa

        ${ignored ["JetBrains Toolbox" "Mullvad VPN" "Sip" "iStat Menus"]}
        ${unmanaged ["GOG Galaxy" "Steam" "System Settings"]}

        # etc.
        ${rule} manage=off border=off app="CleanShot"
        ${rule} manage=off sticky=on  app="OBS Studio"
      '';
  };
}
