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
      "brave-browser"
      "ticktick"
      "firefox"
      "mullvad-browser"
      "stats"
      "lulu"
      "hiddenbar"
      "appcleaner"
      "skiff"
      "1password"
      "tor-browser"
      "macfuse"
      "gimp"
      "jetbrains-toolbox"
      "krita"
      "raycast"
      "karabiner-elements"
      "orion"
      "shottr"
      "linearmouse"
      "veracrypt"
      "obsidian"
      "discord"
      "calibre"
      (skipSha "megasync")
      (skipSha "sizzy")

      # Drivers
      "wacom-tablet"
    ];
    taps = ["homebrew/services" "homebrew/cask"];
  };
}
