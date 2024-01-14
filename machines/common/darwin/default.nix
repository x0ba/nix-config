{
  lib,
  pkgs,
  ...
}: {
  # manipulate the global /etc/zshenv for PATH, etc.
  programs.zsh.enable = true;
  programs.fish.enable = true;
  system.activationScripts.postActivation.text = ''
    # Set the default shell as fish for the user. MacOS doesn't do this like nixOS does
    sudo chsh -s ${pkgs.fish}/bin/fish daniel
  '';

  security.pam.enableSudoTouchIdAuth = true;
  system.stateVersion = 4;
  system.defaults = {
    alf.stealthenabled = 1;
    NSGlobalDomain = {
      AppleKeyboardUIMode = 3;
      ApplePressAndHoldEnabled = false;
      AppleFontSmoothing = 1;
      _HIHideMenuBar = true;
      InitialKeyRepeat = 10;
      KeyRepeat = 1;
      "com.apple.mouse.tapBehavior" = 1;
      "com.apple.swipescrolldirection" = true;
    };
    dock = {
      autohide = true;
      showhidden = true;
      mru-spaces = false;
    };
    finder = {
      AppleShowAllExtensions = true;
      QuitMenuItem = true;
      FXEnableExtensionChangeWarning = true;
    };
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  services = {
    yabai = {
      enable = true;
      enableScriptingAddition = true;
      logFile = "/var/tmp/yabai.log";
      config = {
        auto_balance = "off";
        focus_follows_mouse = "off";
        layout = "bsp";
        mouse_modifier = "alt";
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
        external_bar = "all:0:40";
      };
      extraConfig = let
        rule = "yabai -m rule --add";
        ignored = app: builtins.concatStringsSep "\n" (map (e: ''${rule} app="${e}" manage=off sticky=off layer=above border=off'') app);
        unmanaged = app: builtins.concatStringsSep "\n" (map (e: ''${rule} app="${e}" manage=off'') app);
      in
        /*
        bash
        */
        ''
          # auto-inject scripting additions
          yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"
          sudo yabai --load-sa

          ${ignored ["JetBrains Toolbox" "ProtonVPN" "Sip" "iStat Menus"]}
          ${unmanaged ["GOG Galaxy" "Steam" "System Settings"]}
          yabai -m rule --add label="Finder" app="^Finder$" title="(Co(py|nnect)|Move|Info|Pref)" manage=off
          yabai -m rule --add label="Safari" app="^Safari$" title="^(General|(Tab|Password|Website|Extension)s|AutoFill|Se(arch|curity)|Privacy|Advance)$" manage=off

          # etc.
          ${rule} manage=off app="CleanShot"
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
        lalt - space: yabai -m window --toggle float; yabai -m window --grid 4:4:1:1:2:2
        lalt + shift - space: yabai -m window --toggle float
        # rotate
        lalt + shift - e : yabai -m space --balance
        lalt - r : yabai -m space --rotate 90
        # fullscreen
        lalt - f : yabai -m window --toggle zoom-fullscreen
        # close windows
        lalt - q : $(yabai -m window $(yabai -m query --windows --window | jq -re ".id") --close)

        # open terminal
        lalt - return : open -na Ghostty.app

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
    spacebar = {
      enable = true;
      package = pkgs.spacebar;
      config = {
        position = "bottom";
        height = 40;
        title = "on";
        spaces = "on";
        power = "on";
        clock = "off";
        right_shell = "off";
        padding_left = 20;
        padding_right = 20;
        spacing_left = 25;
        spacing_right = 25;
        text_font = ''"Menlo:Regular:14.0"'';
        icon_font = ''"Symbols Nerd Font:Regular:14.0"'';
        background_color = "0xff161616";
        foreground_color = "0xffffffff";
        space_icon_color = "0xff3ddbd9";
        power_icon_strip = " ";
        space_icon_strip = "一 二 三 四 五 六 七 八 九 十";
        spaces_for_all_displays = "on";
        display_separator = "on";
        display_separator_icon = "|";
        clock_format = ''"%d/%m/%y %R"'';
        right_shell_icon = " ";
        right_shell_command = "whoami";
      };
    };
  };
}
