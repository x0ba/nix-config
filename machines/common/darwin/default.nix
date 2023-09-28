{lib, ...}: {
  # manipulate the global /etc/zshenv for PATH, etc.
  programs.zsh.enable = true;

  system.stateVersion = 4;

  security.pam.enableSudoTouchIdAuth = true;
  system.defaults.alf.stealthenabled = 1;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  services = {
    yabai = {
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
        window_border = "on";
        window_border_blur = "off";
        window_border_width = 2;
        active_window_border_color = "0xff78a9ff";
        normal_window_border_color = "0xff262626";
      };
      extraConfig = let
        rule = "yabai -m rule --add";
        ignored = app: builtins.concatStringsSep "\n" (map (e: ''${rule} app="${e}" manage=off sticky=off layer=above border=off'') app);
        unmanaged = app: builtins.concatStringsSep "\n" (map (e: ''${rule} app="${e}" manage=off'') app);
      in ''
        # auto-inject scripting additions
        yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"
        sudo yabai --load-sa

        ${ignored ["JetBrains Toolbox" "ProtonVPN" "Sip" "Stats" "1Password" "Pika"]}
        ${unmanaged ["GOG Galaxy" "Steam" "System Settings" "VeraCrypt"]}
        yabai -m rule --add label="Finder" app="^Finder$" title="(Co(py|nnect)|Move|Info|Pref)" manage=off
        yabai -m rule --add label="Safari" app="^Safari$" title="^(General|(Tab|Password|Website|Extension)s|AutoFill|Se(arch|curity)|Privacy|Advance)$" manage=off

        # etc.
        ${rule} manage=off border=off app="Shottr"
        ${rule} manage=off sticky=on  app="OBS Studio"
      '';
    };
    skhd = {
      enable = true;
      skhdConfig = ''
        ## Navigation (lalt - ...)
        # Space Navigation (four spaces per display): lalt - {1, 2, 3, 4}

        lalt - 1 : yabai -m space --focus 1
        lalt - 2 : yabai -m space --focus 2
        lalt - 3 : yabai -m space --focus 3
        lalt - 4 : yabai -m space --focus 4
        lalt - 5 : yabai -m space --focus 5
        lalt - 6 : yabai -m space --focus 6
        lalt - 7 : yabai -m space --focus 7
        lalt - 8 : yabai -m space --focus 8
        lalt - 9 : yabai -m space --focus 9

        # Window Navigation (through display borders): lalt - {h, j, k, l}
        lalt - h : yabai -m window --focus west  || yabai -m display --focus west
        lalt - j : yabai -m window --focus south || yabai -m display --focus south
        lalt - k : yabai -m window --focus north || yabai -m display --focus north
        lalt - l : yabai -m window --focus east  || yabai -m display --focus east

        # Float / Unfloat window: lalt - space
        lalt - space : yabai -m window --toggle float; sketchybar --trigger window_focus

        # Close focused window:
        lalt - q : yabai -m window --close

        # Make window zoom to fullscreen: shift + lalt - f
        shift + lalt - f : yabai -m window --toggle zoom-fullscreen; sketchybar --trigger window_focus

        # Make window zoom to parent node: lalt - f
        lalt - f : yabai -m window --toggle zoom-parent; sketchybar --trigger window_focus

        ## Window Movement (shift + lalt - ...)
        # Moving windows in spaces: shift + lalt - {h, j, k, l}
        shift + lalt - h : yabai -m window --warp west || $(yabai -m window --display west && sketchybar --trigger windows_on_spaces && yabai -m display --focus west && yabai -m window --warp last) || yabai -m window --move rel:-10:0
        shift + lalt - j : yabai -m window --warp south || $(yabai -m window --display south && sketchybar --trigger windows_on_spaces && yabai -m display --focus south) || yabai -m window --move rel:0:10
        shift + lalt - k : yabai -m window --warp north || $(yabai -m window --display north && sketchybar --trigger windows_on_spaces && yabai -m display --focus north) || yabai -m window --move rel:0:-10
        shift + lalt - l : yabai -m window --warp east || $(yabai -m window --display east && sketchybar --trigger windows_on_spaces && yabai -m display --focus east && yabai -m window --warp first) || yabai -m window --move rel:10:0

        # Toggle split orientation of the selected windows node: shift + lalt - s
        shift + lalt - s : yabai -m window --toggle split

        # Moving windows between spaces: shift + lalt - {1, 2, 3, 4, p, n } (Assumes 4 Spaces Max per Display)
        shift + lalt - 1 : yabai -m window --space 1
        shift + lalt - 2 : yabai -m window --space 2
        shift + lalt - 3 : yabai -m window --space 3
        shift + lalt - 4 : yabai -m window --space 4
        shift + lalt - 5 : yabai -m window --space 5
        shift + lalt - 6 : yabai -m window --space 6
        shift + lalt - 7 : yabai -m window --space 7
        shift + lalt - 8 : yabai -m window --space 8
        shift + lalt - 9 : yabai -m window --space 9

        shift + lalt - p : yabai -m window --space prev; yabai -m space --focus prev; sketchybar --trigger windows_on_spaces
        shift + lalt - n : yabai -m window --space next; yabai -m space --focus next; sketchybar --trigger windows_on_spaces

        # Mirror Space on X and Y Axis: shift + lalt - {x, y}
        shift + lalt - x : yabai -m space --mirror x-axis
        shift + lalt - y : yabai -m space --mirror y-axis

        ## Stacks (shift + ctrl - ...)
        # Add the active window to the window or stack to the {direction}: shift + ctrl - {h, j, k, l}
        shift + ctrl - h    : yabai -m window  west --stack $(yabai -m query --windows --window | jq -r '.id'); sketchybar --trigger window_focus
        shift + ctrl - j    : yabai -m window south --stack $(yabai -m query --windows --window | jq -r '.id'); sketchybar --trigger window_focus
        shift + ctrl - k    : yabai -m window north --stack $(yabai -m query --windows --window | jq -r '.id'); sketchybar --trigger window_focus
        shift + ctrl - l    : yabai -m window  east --stack $(yabai -m query --windows --window | jq -r '.id'); sketchybar --trigger window_focus

        # Stack Navigation: shift + ctrl - {n, p}
        shift + ctrl - n : yabai -m window --focus stack.next
        shift + ctrl - p : yabai -m window --focus stack.prev

        ## Resize (ctrl + lalt - ...)
        # Resize windows: ctrl + lalt - {h, j, k, l}
        ctrl + lalt - h    : yabai -m window --resize right:-100:0 || yabai -m window --resize left:-100:0
        ctrl + lalt - j    : yabai -m window --resize bottom:0:100 || yabai -m window --resize top:0:100
        ctrl + lalt - k    : yabai -m window --resize bottom:0:-100 || yabai -m window --resize top:0:-100
        ctrl + lalt - l : yabai -m window --resize right:100:0 || yabai -m window --resize left:100:0

        # Equalize size of windows: ctrl + lalt - e
        ctrl + lalt - e : yabai -m space --balance

        # Enable / Disable gaps in current workspace: ctrl + lalt - g
        ctrl + lalt - g : yabai -m space --toggle padding; yabai -m space --toggle gap

        # Enable / Disable window borders in current workspace: ctrl + lalt - b
        ctrl + lalt - b : yabai -m config window_border off
        shift + ctrl + lalt - b : yabai -m config window_border on


        lalt - return : open -na "''${HOME}/Applications/Home Manager Apps/WezTerm.app"
        lalt - e : emacsclient -c -a 'emacs'
      '';
    };
  };
}
