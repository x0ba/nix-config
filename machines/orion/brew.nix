{config, ...}: let
  noQuarantine = name: {
    inherit name;
    args.no_quarantine = true;
  };
  skipSha = name: {
    inherit name;
    args.require_sha = false;
  };
in {
  # make brew available in PATH
  environment.systemPath = [config.homebrew.brewPrefix];

  homebrew = {
    enable = true;
    caskArgs.require_sha = true;
    casks = [
      "1password"
      "appcleaner"
      "bitwarden"
      "brave-browser"
      "calibre"
      (noQuarantine "easy-move-plus-resize")
      (skipSha "element")
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
      "mullvad-browser"
      "nextcloud"
      "obs"
      "obsidian"
      "protonvpn"
      "raycast"
      "signal"
      (skipSha "spacelauncher")
      (skipSha "spotify")
      (skipSha "steam")
      "tailscale"
      "thunderbird"
      "tor-browser"
      "todoist"
      "uninstallpkg"
      "veracrypt"
      "wacom-tablet"
      "yubico-authenticator"
      "yubico-yubikey-manager"
    ];
    onActivation = {
      autoUpdate = true;
      upgrade = true;
    };
    taps = ["homebrew/cask"];
  };
}
