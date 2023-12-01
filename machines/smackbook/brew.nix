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
      "macchanger"
    ];
    casks = let
      skipSha = name: {
        inherit name;
        args = {require_sha = false;};
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
      "obs"
      "obsidian"
      "orion"
      "osu"
      "polypane"
      "shottr"
      "skiff"
      "stats"
      "uninstallpkg"
      "utm"
      "veracrypt"
      "yubico-authenticator"
      "yubico-yubikey-manager"
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
