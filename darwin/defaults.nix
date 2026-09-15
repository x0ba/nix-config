{ ... }: {
  system.defaults = {
    NSGlobalDomain = {
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
      AppleInterfaceStyleSwitchesAutomatically = true;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = true;
    };
    dock = {
      autohide = true;
      magnification = false;
      largesize = 100;
      tilesize = 62;
      orientation = "bottom";
      show-recents = true;
      showhidden = true;
    };
    menuExtraClock = {
      ShowAMPM = false;
      ShowDate = 0;
      ShowDayOfWeek = false;
    };
  };
}
