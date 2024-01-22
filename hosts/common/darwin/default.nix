{
  lib,
  pkgs,
  ...
}: let
  scripts = ../../../configs/sketchybar/scripts;
in {
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
      enable = false;
      enableScriptingAddition = true;
      logFile = "/var/tmp/yabai.log";
      config = {
        # Layout
        layout = "bsp";
        auto_balance = "off";
        split_ratio = "0.50";
        window_placement = "second_child";
        # Gaps
        window_gap = 5;
        left_padding = 5;
        right_padding = 5;
        top_padding = 5;
        bottom_padding = 5;
        external_bar = "all:0:40";
        # Mouse
        mouse_modifier = "alt";
        mouse_drop_action = "swap";
        mouse_follows_focus = "off";
        window_shadow = "float";
        focus_follows_mouse = "off";
      };
      extraConfig = ''
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
        # # focus window
        # lalt - h : yabai -m window --focus west
        # lalt - j : yabai -m window --focus south
        # lalt - k : yabai -m window --focus north
        # lalt - l : yabai -m window --focus east
        # # move window
        # lalt + shift - h : yabai -m window --warp west
        # lalt + shift - j : yabai -m window --warp south
        # lalt + shift - k : yabai -m window --warp north
        # lalt + shift - l : yabai -m window --warp east
        # # resize window
        # ctrl + lalt - h    : yabai -m window --resize right:-100:0 || yabai -m window --resize left:-100:0
        # ctrl + lalt - j    : yabai -m window --resize bottom:0:100 || yabai -m window --resize top:0:100
        # ctrl + lalt - k    : yabai -m window --resize bottom:0:-100 || yabai -m window --resize top:0:-100
        # ctrl + lalt - l : yabai -m window --resize right:100:0 || yabai -m window --resize left:100:0
        # # toggle sticky/floating
        # lalt - space: yabai -m window --toggle float; yabai -m window --grid 4:4:1:1:2:2
        # lalt + shift - space: yabai -m window --toggle float
        # # rotate
        # lalt + shift - e : yabai -m space --balance
        # lalt - r : yabai -m space --rotate 90
        # # fullscreen
        # lalt - f : yabai -m window --toggle zoom-fullscreen
        # # close windows
        # lalt - q : $(yabai -m window $(yabai -m query --windows --window | jq -re ".id") --close)
        #
        # open terminal
        lalt - return : open -na Ghostty.app
        lalt - e : emacsclient -c
        lalt - v : emacsclient --eval "(emacs-everywhere)"
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
        text_font = ''"Liga SFMono Nerd Font:Regular:16.0"'';
        icon_font = ''"Liga SFMono Nerd Font:Regular:16.0"'';
        background_color = "0xff161616";
        foreground_color = "0xffFFFFFF";
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
    karabiner-elements.enable = true;
    emacs = {
      enable = true;
      package = pkgs.emacs;
    };
    nextdns = {
      enable = true;
      arguments = ["-profile en0=7b4d8c"];
    };
  };
}
