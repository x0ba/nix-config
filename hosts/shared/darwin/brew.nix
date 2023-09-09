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
        noQuarantine = name: {
          inherit name;
          args = { no_quarantine = true; };
        };
      in
      [
        "brave-browser"
        "signal"
        "firefox"
        "1password"
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
