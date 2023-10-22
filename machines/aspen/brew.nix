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
      "php"
    ];
    casks = let
      noQuarantine = name: {
        inherit name;
        args = {no_quarantine = true;};
      };
      skipSha = name: {
        inherit name;
        args = {require_sha = false;};
      };
    in [
      "firefox"
      "bitwarden"
      "eloston-chromium"
      "alex313031-thorium"
      "1password"
      "hiddenbar"
      "uninstallpkg"
      "anki"
      "imageoptim"
      "protonvpn"
      "stats"
      "lulu"
      "obs"
      "appcleaner"
      "skiff"
      "aldente"
      "macfuse"
      "gimp"
      "jetbrains-toolbox"
      "krita"
      "raycast"
      "iina"
      "polypane"
      "karabiner-elements"
      "shottr"
      "linearmouse"
      "veracrypt"
      "obsidian"
      "discord"
      "calibre"
      (skipSha "element")
      (skipSha "spotify")
      (skipSha "nvidia-geforce-now")

      # Drivers
      "wacom-tablet"
      (skipSha "logitech-options")
    ];
    taps = ["homebrew/services" "homebrew/cask"];
  };
}
