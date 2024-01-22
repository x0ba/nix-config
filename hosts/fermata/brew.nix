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
      "calibre"
      "hiddenbar"
      "iina"
      (noQuarantine "easy-move-plus-resize")
      "rectangle"
      (skipSha "discord")
      "jetbrains-toolbox"
      "linearmouse"
      "protonvpn"
      "little-snitch"
      "macfuse"
      "mullvad-browser"
      "obsidian"
      "raycast"
      (skipSha "spotify")
      "tor-browser"
      "veracrypt"
      "wacom-tablet"
      "yubico-authenticator"
    ];
    taps = ["d12frosted/emacs-plus" "homebrew/services"];
  };
}
