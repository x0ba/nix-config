{
  homebrew = {
    enable = true;
    caskArgs.require_sha = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };
    casks =
      let
        skipSha = name: {
          inherit name;
          args = { require_sha = false; };
        };
        noQuarantine = name: {
          inherit name;
          args = { no_quarantine = true; };
        };
      in
      [
        "brave-browser"
        "firefox"
        "mullvad-browser"
        "iina"
        "stats"
        "lulu"
        "hiddenbar"
        "appcleaner"
        "skiff"
        "anki"
        "tor-browser"
        "macfuse"
        "keka"
        "syncthing"
        "gimp"
        "jetbrains-toolbox"
        "krita"
        "raycast"
        "karabiner-elements"
        "whichspace"
        "shottr"
        "bitwarden"
        "linearmouse"
        "veracrypt"
        "obsidian"
        "discord"
        "calibre"
        "ticktick"
        (noQuarantine "librewolf")

        # Drivers
        "wacom-tablet"
      ];
    taps = [ "homebrew/services" "homebrew/cask" "nextfire/tap" ];
  };
}
