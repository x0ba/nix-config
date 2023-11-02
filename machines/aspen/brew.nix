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
      "todoist"
      "arc"
      "bitwarden"
      "raycast"
      "1password"
      "uninstallpkg"
      "anki"
      "imageoptim"
      "protonvpn"
      "stats"
      "lulu"
      "numi"
      "obs"
      "shottr"
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
      (skipSha "beeper")
      (skipSha "spotify")

      # Drivers
      "wacom-tablet"
      (skipSha "logitech-options")
    ];
    taps = ["homebrew/services" "homebrew/cask"];
  };
}
