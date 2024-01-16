{config, ...}: let
  skipSha = name: {
    inherit name;
    args.require_sha = false;
  };
  noQuarantine = name: {
    inherit name;
    args.no_quarantine = true;
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
      "brave-browser"
      "calibre"
      "iina"
      "jetbrains-toolbox"
      "linearmouse"
      "little-snitch"
      "macfuse"
      "mullvad-browser"
      "obsidian"
      "orion"
      (skipSha "spotify")
      "tor-browser"
      "veracrypt"
      "yubico-authenticator"
    ];
    taps = ["homebrew/cask-versions"];
  };
}
