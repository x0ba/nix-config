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
      "appcleaner"
      "bitwarden"
      "calibre"
      "firefox"
      "gimp"
      "iina"
      "imageoptim"
      "insomnia"
      "jetbrains-toolbox"
      "karabiner-elements"
      "keka"
      "linearmouse"
      "little-snitch"
      "macfuse"
      "obs"
      "obsidian"
      "proton-drive"
      "protonvpn"
      "raycast"
      "tor-browser"
      "uninstallpkg"
      "veracrypt"
      "yubico-authenticator"
      "yubico-yubikey-manager"
      (skipSha "spotify")
      (skipSha "protonmail-bridge")
      (skipSha "element")

      # Drivers
      "wacom-tablet"
    ];
    taps = [
      "homebrew/cask"
    ];
  };
}
