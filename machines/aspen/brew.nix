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
      "1password"
      "anki"
      "appcleaner"
      "bitwarden"
      "calibre"
      "docker"
      "firefox"
      "gimp"
      "iina"
      "imageoptim"
      "jetbrains-toolbox"
      "karabiner-elements"
      "krita"
      "linearmouse"
      "lulu"
      "macfuse"
      "mos"
      "obs"
      "obsidian"
      "polypane"
      "protonvpn"
      "qutebrowser"
      "raycast"
      "shottr"
      "skiff"
      "stats"
      "todoist"
      "uninstallpkg"
      "veracrypt"
      (skipSha "element")
      (skipSha "spotify")

      # Drivers
      "wacom-tablet"
    ];
    taps = ["homebrew/services" "homebrew/cask"];
  };
}
