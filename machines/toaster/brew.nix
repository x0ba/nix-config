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
      "anki"
      "appcleaner"
      "calibre"
      "firefox"
      "gimp"
      "iina"
      "imageoptim"
      "jetbrains-toolbox"
      "karabiner-elements"
      "linearmouse"
      "lulu"
      "macfuse"
      "mos"
      "obs"
      "obsidian"
      "orion"
      "polypane"
      "protonvpn"
      "eloston-chromium"
      "raycast"
      "shottr"
      "sioyek"
      "skiff"
      "stats"
      "uninstallpkg"
      "utm"
      "veracrypt"
      "osu"
      (skipSha "spotify")
      (skipSha "tetrio")

      # Drivers
      "wacom-tablet"
    ];
    taps = ["homebrew/cask" "FelixKratz/formulae"];
  };
}
