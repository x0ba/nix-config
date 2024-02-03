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
    brews = [
      {
        name = "emacs-plus";
        args = [
          "with-native-comp"
          "with-xwidgets"
          "with-poll"
          "with-savchenkovaleriy-big-sur-icon"
          "with-no-frame-refocus"
        ];
        start_service = true;
      }
      "cmake"
      "gcc"
      "libtool"
    ];
    casks = [
      "1password"
      "anki"
      "appcleaner"
      "calibre"
      (noQuarantine "easy-move-plus-resize")
      "flux"
      "hiddenbar"
      "eloston-chromium"
      "rectangle"
      "iina"
      "jetbrains-toolbox"
      "linearmouse"
      "little-snitch"
      "macfuse"
      "obsidian"
      "orion"
      "raycast"
      "shottr"
      (skipSha "spotify")
      "tor-browser"
      "veracrypt"
      "wacom-tablet"
      "yubico-authenticator"
    ];
    taps = ["homebrew/services" "d12frosted/emacs-plus"];
  };
}
