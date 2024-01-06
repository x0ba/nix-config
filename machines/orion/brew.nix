{config, ...}: let
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
    masApps = {
      "Skiff Desktop" = 1615488683;
    };
    brews = [
      "php"
    ];
    casks = [
      "1password"
      "appcleaner"
      "bitwarden"
      "brave-browser"
      "calibre"
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
      "obs"
      "obsidian"
      "protonvpn"
      "signal"
      (skipSha "spacelauncher")
      (skipSha "spotify")
      (skipSha "steam")
      "tailscale"
      (skipSha "tetrio")
      "tor-browser"
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
