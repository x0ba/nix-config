{...}: {

  users.users.daniel.home = "/Users/daniel";

  system.stateVersion = 4;
  services.nix-daemon.enable = true;
  system.defaults.alf.stealthenabled = 1;
  nixpkgs.hostPlatform = "aarch64-darwin";

  programs.zsh.enable = true;
  security.pam.enableSudoTouchIdAuth = true;

  system.keyboard = {
    enableKeyMapping = true;
    # remapCapsLockToControl = true;
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
      _HIHideMenuBar = false;
      # InitialKeyRepeat = 10;
      # KeyRepeat = 1;
      "com.apple.mouse.tapBehavior" = 1;
      "com.apple.swipescrolldirection" = true;
    };
  };
}
