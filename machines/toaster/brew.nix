{config, ...}: {
  environment.systemPath = [config.homebrew.brewPrefix];
  homebrew = {
    enable = true;
    caskArgs.require_sha = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };
    brews = [
      {
        name = "d12frosted/emacs-plus/emacs-plus";
        start_service = true;
      }
    ];
    casks = let
      skipSha = name: {
        inherit name;
        args = {require_sha = false;};
      };
      noQuarantine = name: {
        inherit name;
        args = {no_quarantine = true;};
      };
    in [
      "1password"
      "appcleaner"
      "calibre"
      "eloston-chromium"
      "firefox"
      "gimp"
      "iina"
      "imageoptim"
      "jetbrains-toolbox"
      "karabiner-elements"
      "linearmouse"
      "macfuse"
      "mos"
      "obs"
      "obsidian"
      "orion"
      "osu"
      "polypane"
      "raycast"
      "shottr"
      "sioyek"
      "skiff"
      "stats"
      "uninstallpkg"
      "utm"
      "veracrypt"
      (skipSha "spotify")
      (skipSha "tetrio")

      # Drivers
      "wacom-tablet"
    ];
    taps = [
      "homebrew/services"
    ];
  };
}
