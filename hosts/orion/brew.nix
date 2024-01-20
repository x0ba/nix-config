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
    brews = [
      {
        name = "emacs-plus";
        args = ["with-native-comp"];
        start_service = true;
      }
      "libvterm"
      "cmake"
      "gcc"
    ];
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
      "hiddenbar"
      "iina"
      "jetbrains-toolbox"
      "firefox"
      "linearmouse"
      "little-snitch"
      "macfuse"
      "mullvad-browser"
      "obsidian"
      "orion"
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
