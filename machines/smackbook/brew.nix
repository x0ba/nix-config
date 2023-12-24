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
      # "1password"
      "appcleaner"
      "bitwarden"
      "calibre"
      "firefox"
      "gimp"
      "iina"
      "imageoptim"
      "proton-drive"
      "jetbrains-toolbox"
      "karabiner-elements"
      "keka"
      "linearmouse"
      "little-snitch"
      "macfuse"
      "protonvpn"
      "insomnia"
      "obs"
      "obsidian"
      "raycast"
      "rectangle"
      "skiff"
      "tor-browser"
      "uninstallpkg"
      "tailscale"
      "utm"
      "veracrypt"
      "yubico-authenticator"
      "yubico-yubikey-manager"
      (noQuarantine "easy-move-plus-resize")
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
