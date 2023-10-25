{
  lib,
  config,
  pkgs,
  ...
}: {
  # manipulate the global /etc/zshenv for PATH, etc.
  programs.zsh.enable = true;
  programs.fish.enable = true;
  system.activationScripts.postActivation.text = ''
    # Set the default shell as fish for the user. MacOS doesn't do this like nixOS does
    sudo chsh -s ${pkgs.zsh}/bin/zsh daniel
  '';

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
        window_border = "off";
        window_border_blur = "off";
        window_border_width = 2;
        active_window_border_color = "0xffAB8A65";
        normal_window_border_color = "0xff404040";
      };
      extraConfig = let
        rule = "yabai -m rule --add";
        ignored = app: builtins.concatStringsSep "\n" (map (e: ''${rule} app="${e}" manage=off sticky=off layer=above border=off'') app);
        unmanaged = app: builtins.concatStringsSep "\n" (map (e: ''${rule} app="${e}" manage=off'') app);
      in ''
        # auto-inject scripting additions
        yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"
        sudo yabai --load-sa

        ${ignored ["JetBrains Toolbox" "ProtonVPN" "Sip" "Stats" "1Password" "Pika" "LuLu Alert"]}
        ${unmanaged ["GOG Galaxy" "Steam" "System Settings" "VeraCrypt"]}
        yabai -m rule --add app="^1Password$" manage=off
        yabai -m rule --add app="^Stats$" manage=off
        yabai -m rule --add label="Finder" app="^Finder$" title="(Co(py|nnect)|Move|Info|Pref)" manage=off
        yabai -m rule --add label="LuLu" app="^LuLu$" title="(Alert)" manage=off
        yabai -m rule --add label="Safari" app="^Safari$" title="^(General|(Tab|Password|Website|Extension)s|AutoFill|Se(arch|curity)|Privacy|Advance)$" manage=off

        # etc.
        ${rule} manage=off border=off app="Shottr"
        ${rule} manage=off sticky=on  app="OBS Studio"
      '';
    };
    skhd = {
      enable = true;
      skhdConfig = let
        mapKeymaps = with builtins;
          cmd:
            concatStringsSep "\n" (map (i:
              replaceStrings ["Num"] [
                (toString (
                  if (i == 10)
                  then 0
                  else i
                ))
              ]
              cmd) (lib.range 1 10));
      in ''
        #!/usr/bin/env sh


        ctrl - left  : yabai -m space --focus prev
        ctrl - right : yabai -m space --focus next

        # send window to desktop and follow
        ${mapKeymaps "lalt + shift - Num : yabai -m window --space Num; yabai -m space --focus Num"}

        # switch to desktop
        ${mapKeymaps "lalt - Num : yabai -m space --focus Num"}

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

        lalt - return : open -na "''${HOME}/Applications/Home Manager Apps/WezTerm.app"
      '';
    };
  };
}
