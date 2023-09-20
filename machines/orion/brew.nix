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
      "blender"
      "brave-browser"
      "eloston-chromium"
      "firefox"
      "stats"
      "lulu"
      "hiddenbar"
      "obs"
      "appcleaner"
      "rustdesk"
      "skiff"
      "1password"
      "tor-browser"
      "macfuse"
      "gimp"
      "jetbrains-toolbox"
      "krita"
      "raycast"
      "iina"
      "karabiner-elements"
      "orion"
      "protonvpn"
      "osu"
      "shottr"
      "linearmouse"
      "veracrypt"
      "obsidian"
      "discord"
      "calibre"
      (skipSha "megasync")

      # Drivers
      "wacom-tablet"
      (skipSha "logitech-options")
    ];
    taps = ["homebrew/services" "homebrew/cask"];
  };
}
