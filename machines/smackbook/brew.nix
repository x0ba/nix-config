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
      "bitwarden"
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
      "mullvad-browser"
      "mullvadvpn"
      "obs"
      "obsidian"
      "rectangle"
      "skiff"
      "tor-browser"
      "uninstallpkg"
      "utm"
      "veracrypt"
      "yubico-authenticator"
      "yubico-yubikey-manager"
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
