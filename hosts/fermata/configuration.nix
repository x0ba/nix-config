{ ... }:
{
  imports = [ ./brew.nix ];

  programs.zsh.enable = true;

  system = {
    defaults = {
      alf = {
        stealthenabled = 1;
        globalstate = 1;
      };
      NSGlobalDomain = {
        InitialKeyRepeat = 10;
        KeyRepeat = 1;

        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.sound.beep.volume" = 0.0;
        "com.apple.sound.beep.feedback" = 0;
      };
      dock = {
        autohide = true;
        show-recents = false;
        showhidden = true;
        launchanim = true;
        mru-spaces = false;
        mouse-over-hilite-stack = true;
        orientation = "left";
        tilesize = 48;
      };
    };
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };
  };

  nix = {
    gc = {
      user = "root";
      automatic = true;
      interval = {
        Weekday = 0;
        Hour = 2;
        Minute = 0;
      };
      options = "--delete-older-than 30d";
    };
  };

  system.checks.verifyNixPath = false;
  services.nix-daemon.enable = true;
}
