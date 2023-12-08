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
    in [
      "1password"
      "appcleaner"
      "calibre"
      "eloston-chromium"
      "firefox"
      "gimp"
      "iina"
      "imageoptim"
      "easy-move-plus-resize"
      "rectangle"
      "jetbrains-toolbox"
      "karabiner-elements"
      "linearmouse"
      "macfuse"
      "mullvad-browser"
      "mullvadvpn"
      "obs"
      "obsidian"
      "orion"
      "skiff"
      "stats"
      "uninstallpkg"
      "veracrypt"
      "yubico-authenticator"
      "yubico-yubikey-manager"
      (skipSha "spotify")

      # Drivers
      "wacom-tablet"
    ];
    taps = [
      "homebrew/services"
    ];
  };
}
