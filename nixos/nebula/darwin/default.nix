{
  pkgs,
  lib,
  inputs,
  outputs,
  config,
  ...
}: {
  imports = [
    ./programs/yabai.nix
    ./programs/skhd.nix
    ./programs/fish.nix
  ];

  programs.zsh.enable = true;
  system.stateVersion = 4;
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };
  system.defaults = {
    screencapture = {location = "/tmp";};
    dock = {
      autohide = true;
      showhidden = true;
      mru-spaces = false;
    };
    finder = {
      AppleShowAllExtensions = true;
      QuitMenuItem = true;
      AppleShowAllFiles = true;
      CreateDesktop = false;
      FXEnableExtensionChangeWarning = true;
    };
    NSGlobalDomain = {
      AppleKeyboardUIMode = 3;
      ApplePressAndHoldEnabled = false;
      AppleFontSmoothing = 1;
      _HIHideMenuBar = true;
      # InitialKeyRepeat = 10;
      # KeyRepeat = 1;
      "com.apple.mouse.tapBehavior" = 1;
      "com.apple.swipescrolldirection" = true;
    };
  };
}
