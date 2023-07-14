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
    (import ./programs/fish.nix { inherit config inputs lib pkgs; })
  ];

  programs.zsh.enable = true;
  system.stateVersion = 4;
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };
  # fonts = {
  #   fontDir.enable = true;
  #   fonts = with pkgs; [
  #     maple-mono-SC-NF
  #     (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
  #   ];
  # };
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
      AppleShowAllFiles = true;
      CreateDesktop = false;
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
