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
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };
    masApps = {
      "Skiff Desktop" = 1615488683;
      "Adguard for Safari" = 1440147259;
      "1Password for Safari" = 1569813296;
      "Vimari" = 1480933944;
    };
    casks = [
      "1password"
      "appcleaner"
      "bitwarden"
      "brave-browser"
      "calibre"
      "eloston-chromium"
      (skipSha "element")
      "gimp"
      "iina"
      "hiddenbar"
      "imageoptim"
      "insomnia"
      "jetbrains-toolbox"
      "karabiner-elements"
      "keka"
      "linearmouse"
      "little-snitch"
      "macfuse"
      "monal"
      "mullvad-browser"
      "obs"
      "obsidian"
      "protonvpn"
      "raycast"
      (skipSha "spotify")
      "tailscale"
      "tor-browser"
      "uninstallpkg"
      "veracrypt"
      "yubico-authenticator"
      "yubico-yubikey-manager"
    ];
  };
}
