{ pkgs
, lib
, inputs
, outputs
, config
, ...
}: {
  imports = [
    (import ./programs/yabai.nix { inherit config inputs lib pkgs; })
    (import ./programs/skhd.nix { inherit config inputs lib pkgs; })
    # (import ./programs/sketchybar.nix { inherit config inputs lib pkgs; })
    (import ./programs/fish.nix { inherit config inputs lib pkgs; })
  ];
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };
  system.defaults = {
    screencapture = { location = "/tmp"; };
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
  };
}
