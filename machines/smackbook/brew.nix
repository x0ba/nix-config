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
      "appcleaner"
      "brave-browser"
      "calibre"
      "gimp"
      "iina"
      "imageoptim"
      "jetbrains-toolbox"
      "karabiner-elements"
      "keka"
      "linearmouse"
      "little-snitch"
      "macfuse"
      "mullvadvpn"
      "obs"
      "obsidian"
      "raycast"
      "rectangle"
      "skiff"
      "tor-browser"
      "uninstallpkg"
      "utm"
      "veracrypt"
      "vivaldi"
      "yubico-authenticator"
      (noQuarantine "easy-move-plus-resize")
      (skipSha "spotify")
      (skipSha "element")

      # Drivers
      "wacom-tablet"
    ];
    taps = [
      "homebrew/cask"
    ];
  };
}
