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
      "calibre"
      "discord-canary"
      "eloston-chromium"
      "iina"
      "jetbrains-toolbox"
      "karabiner-elements"
      "linearmouse"
      "little-snitch"
      "macfuse"
      "mullvad-browser"
      (skipSha "nvidia-geforce-now")
      "obs"
      "obsidian"
      (skipSha "spotify")
      "tailscale"
      "tor-browser"
      "veracrypt"
      "yubico-authenticator"
      "yubico-yubikey-manager"
    ];
    taps = ["homebrew/cask-versions"];
  };
}
