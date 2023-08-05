{...}: {
  imports = [
    ./programs/yabai.nix
    ./programs/skhd.nix
    ./programs/fish.nix
    ./brew.nix
    ./nix.nix
  ];

  system.stateVersion = 4;
  services.nix-daemon.enable = true;
  nixpkgs.hostPlatform = "aarch64-darwin";

  programs.zsh.enable = true;

  security.pam.enableSudoTouchIdAuth = true;

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
