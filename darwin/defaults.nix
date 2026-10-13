{ ... }: {
  system.defaults = {
    NSGlobalDomain = {
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
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
      autohide = true;
      tilesize = 64;
      show-recents = true;
      showhidden = true;
    };
  };
}
