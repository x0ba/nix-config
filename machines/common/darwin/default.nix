{
  lib,
  pkgs,
  ...
}: {
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
      package = pkgs.yabai.overrideAttrs (prev: {
        version = "6.0.2";
        src = pkgs.fetchzip {
          inherit (prev.src) url;
          hash = "sha256-CXkGVoJcGSkooxe7eIhwaM6FkOI45NVw5jdLJAzgFBM=";
        };
      });
      logFile = "/var/tmp/yabai.log";
      config = {
        auto_balance = "off";
        focus_follows_mouse = "off";
        layout = "bsp";
        mouse_drop_action = "swap";
        mouse_follows_focus = "off";
        window_animation_duration = "0.0";
        window_gap = 5;
        left_padding = 5;
        right_padding = 5;
        top_padding = 5;
        bottom_padding = 5;
        window_origin_display = "default";
        window_placement = "second_child";
        window_shadow = "float";
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
        ${unmanaged ["GOG Galaxy" "Steam" "System Settings" "1Password"]}
        yabai -m rule --add label="Finder" app="^Finder$" title="(Co(py|nnect)|Move|Info|Pref)" manage=off
        yabai -m rule --add label="Safari" app="^Safari$" title="^(General|(Tab|Password|Website|Extension)s|AutoFill|Se(arch|curity)|Privacy|Advance)$" manage=off

        # etc.
        yabai -m rule --add app="CleanShot X" manage=off mouse_follows_focus=off
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
        # focus window
        lalt - h : yabai -m window --focus west
        lalt - j : yabai -m window --focus south
        lalt - k : yabai -m window --focus north
        lalt - l : yabai -m window --focus east
        # move window
        lalt + shift - h : yabai -m window --warp west
        lalt + shift - j : yabai -m window --warp south
        lalt + shift - k : yabai -m window --warp north
        lalt + shift - l : yabai -m window --warp east
        # resize window
        ctrl + lalt - h    : yabai -m window --resize right:-100:0 || yabai -m window --resize left:-100:0
        ctrl + lalt - j    : yabai -m window --resize bottom:0:100 || yabai -m window --resize top:0:100
        ctrl + lalt - k    : yabai -m window --resize bottom:0:-100 || yabai -m window --resize top:0:-100
        ctrl + lalt - l : yabai -m window --resize right:100:0 || yabai -m window --resize left:100:0
        # toggle sticky/floating
        lalt - space : yabai -m window --toggle float; sketchybar --trigger window_focus
        lalt + shift - space: yabai -m window --toggle float
        # rotate
        lalt + shift - e : yabai -m space --balance
        lalt + shift - r : yabai -m space --rotate 270

        # open terminal
        lalt - return : open -na "WezTerm"

        # ONLY WORKS WITH SIP DISABLED:
        # fast focus space left/right
        ctrl - left  : yabai -m space --focus prev
        ctrl - right : yabai -m space --focus next
        # switch to space
        ${mapKeymaps "lalt - Num : yabai -m space --focus Num"}
        # send window to desktop and follow focus
        ${mapKeymaps "lalt + shift - Num : yabai -m window --space Num; yabai -m space --focus Num"}
      '';
    };
  };
}
