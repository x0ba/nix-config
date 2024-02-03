{
  lib,
  pkgs,
  ...
}: {
  programs.zsh.enable = true;
  programs.fish.enable = true;

  system.activationScripts.postActivation.text = ''
    # Set the default shell as fish for the user. MacOS doesn't do this like nixOS does
    sudo chsh -s ${pkgs.zsh}/bin/zsh daniel
  '';

  system.stateVersion = 4;

  security.pam.enableSudoTouchIdAuth = true;
  system = {
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
    defaults = {
      alf.stealthenabled = 1;
      NSGlobalDomain = {
        AppleKeyboardUIMode = 3;
        ApplePressAndHoldEnabled = false;
        AppleFontSmoothing = 1;
        _HIHideMenuBar = false;
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
  };

  services = {
    # Auto upgrade nix package and the daemon service.
    nix-daemon.enable = true;
    yabai = {
      enable = true;
      enableScriptingAddition = true;
      logFile = "/var/tmp/yabai.log";
      config = {
        # Layout
        layout = "bsp";
        auto_balance = "off";
        split_ratio = "0.50";
        window_placement = "second_child";
        # Gaps
        window_gap = 10;
        left_padding = 10;
        right_padding = 10;
        top_padding = 10;
        bottom_padding = 10;
        # external_bar = "all:0:40";
        # Opeacity
        window_shadow = "on";
        window_opacity = "on";
        window_opacity_duration = "0.1";
        active_window_opacity = "1.0";
        normal_window_opacity = "1.0";
        # Mouse
        mouse_modifier = "alt";
        mouse_action1 = "move";
        mouse_action2 = "resize";
        mouse_drop_action = "swap";
      };
      extraConfig = ''
        # Unload the macOS WindowManager process
        launchctl unload -F /System/Library/LaunchAgents/com.apple.WindowManager.plist > /dev/null 2>&1 &
        # auto-inject scripting additions
        yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"
        sudo yabai --load-sa
        # rules
        yabai -m rule --add app="^(LuLu|Vimac|Calculator|Software Update|Dictionary|VLC|System Settings|zoom.us|Photo Booth|Archive Utility|Python|LibreOffice|App Store|Steam|Alfred|Activity Monitor)$" manage=off
        yabai -m rule --add label="Finder" app="^Finder$" title="(Co(py|nnect)|Move|Info|Pref)" manage=off
        yabai -m rule --add label="Safari" app="^Safari$" title="^(General|(Tab|Password|Website|Extension)s|AutoFill|Se(arch|curity)|Privacy|Advance)$" manage=off
        yabai -m rule --add label="About This Mac" app="System Information" title="About This Mac" manage=off
        yabai -m rule --add label="Select file to save to" app="^Inkscape$" title="Select file to save to" manage=off
        yabai -m rule --add title="^Emacs Everywhere.*" manage=off
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
        ctrl + cmd - h : yabai -m window --focus west
        ctrl + cmd - j : yabai -m window --focus south
        ctrl + cmd - k : yabai -m window --focus north
        ctrl + cmd - l : yabai -m window --focus east
        # move window
        cmd + shift - h : yabai -m window --warp west
        cmd + shift - j : yabai -m window --warp south
        cmd + shift - k : yabai -m window --warp north
        cmd + shift - l : yabai -m window --warp east
        ctrl + cmd - t : yabai -m window --toggle float;\
                   yabai -m window --grid 4:4:1:1:2:2
        # rotate
        cmd + shift - e : yabai -m space --balance
        cmd + shift - r : yabai -m space --rotate 90
        # fullscreen
        ctrl + cmd - f : yabai -m window --toggle zoom-fullscreen
        # close current window
        ctrl + cmd - w : $(yabai -m window $(yabai -m query --windows --window | jq -re ".id") --close)

        # ONLY WORKS WITH SIP DISABLED:
        # fast focus space left/right
        ctrl - left  : yabai -m space --focus prev
        ctrl - right : yabai -m space --focus next
        # switch to space
        ${mapKeymaps "lalt - Num : yabai -m space --focus Num"}
        # send window to desktop and follow focus
        ${mapKeymaps
          "lalt + shift - Num : yabai -m window --space Num; yabai -m space --focus Num"}

        # Open new Alacritty window
        cmd + shift - return : open -na WezTerm.app

        # open emacs
        cmd - e : emacsclient -c
        cmd + lalt - e : emacsclient --eval "(emacs-everywhere)"
      '';
    };
    spacebar = {
      enable = false;
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
        text_font = ''"Overpass:Regular:16.0"'';
        icon_font = ''"Overpass:Regular:16.0"'';
        background_color = "0xff161616";
        foreground_color = "0xffFFFFFF";
        space_icon_color = "0xff3ddbd9";
        power_icon_strip = " ";
        space_icon_strip = "1 2 3 4 5 6 7 8 9 10";
        spaces_for_all_displays = "on";
        display_separator = "on";
        display_separator_icon = "|";
        clock_format = ''"%d/%m/%y %R"'';
        right_shell_icon = " ";
        right_shell_command = "whoami";
      };
    };
    karabiner-elements.enable = true;
    emacs = {
      enable = false;
      package = pkgs.emacs;
    };
    nextdns = {
      enable = true;
      arguments = ["-profile en0=7b4d8c"];
    };
  };
}
