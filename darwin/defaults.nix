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
    trackpad.Clicking = true;
    finder = {
      FXPreferredViewStyle = "Nlsv";
      FXRemoveOldTrashItems = true;
    };
    dock = {
      magnification = false;
      tilesize = 64;
      show-recents = true;
      showhidden = true;
    };
  };
}
