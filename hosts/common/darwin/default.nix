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
    sudo chsh -s ${pkgs.fish}/bin/fish daniel
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
        window_gap = 5;
        left_padding = 5;
        right_padding = 5;
        top_padding = 5;
        bottom_padding = 5;
        # external_bar = "all:0:40";
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
        yabai -m rule --add title="^Emacs Everywhere" title="Select file to save to" manage=off
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
        lalt - e : emacsclient -c
        lalt - v : emacsclient --eval "(emacs-everywhere)"

        # ONLY WORKS WITH SIP DISABLED:
        # fast focus space left/right
        ctrl - left  : yabai -m space --focus prev
        ctrl - right : yabai -m space --focus next
        # switch to space
        ${mapKeymaps "lalt - Num : yabai -m space --focus Num"}
        # send window to desktop and follow focus
        ${mapKeymaps
          "lalt + shift - Num : yabai -m window --space Num; yabai -m space --focus Num"}
      '';
    };
    sketchybar = {
      enable = false;
      package = pkgs.sketchybar;
      config = ''
        #!/bin/bash

        ############## BAR ##############
        sketchybar --bar height=40 \
                         position=bottom \
                         shadow=on \
                         color=0xff131a1c \

        ############## GLOBAL DEFAULTS ##############
        sketchybar --default updates=when_shown \
                             icon.font="Overpass:Bold:15.0" \
                             label.font="Overpass:Regular:15.0" \
                             icon.color=0xffc5c8c9 \
                             label.color=0xffc5c8c9 \
                             background.color=0xff131a1c \
                             background.padding_left=9 \
                             background.padding_right=9 \
                             background.height=40

        ############## ITEMS ###############
        SPACE_ICONS=("一" "二" "三" "四" "五" "六" "七" "八" "九" "十")
        SPACES=()
        sid=0
        for i in "''${!SPACE_ICONS[@]}"
        do
          sid=$(($i+1))
          sketchybar --add space space.$sid left \
                     --set space.$sid associated_space=$sid \
                                      icon=''${SPACE_ICONS[i]} \
                                      icon.padding_left=12 \
                                      icon.padding_right=12 \
                                      icon.highlight_color=0xff8aadf4 \
                                      background.padding_left=-4 \
                                      background.padding_right=-4 \
                                      background.drawing=on \
                                      label.drawing=off \
                                      click_script="yabai -m space --focus \$SID 2>/dev/null"
        done

        sketchybar --add item text1 center \
                        icon.font="Overpass:Bold:15.0"

        sketchybar --add item window_title center \
                   --set window_title    script="${scripts}/window_title.sh" \
                                         icon.drawing=off \
                                         label.color=0xffc5c8c9 \
                   --subscribe window_title front_app_switched


        ############## FINALIZING THE SETUP ##############
        sketchybar --update
      '';
    };
    karabiner-elements.enable = true;
    nextdns = {
      enable = true;
      arguments = ["-profile en0=7b4d8c"];
    };
  };
}
