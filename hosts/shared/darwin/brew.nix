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
        "firefox"
        "brave-browser"
        "stats"
        "mullvad-browser"
        "iina"
        "lulu"
        "dozer"
        "appcleaner"
        "skiff"
        "anki"
        "tor-browser"
        "macfuse"
        "uninstallpkg"
        "keka"
        "syncthing"
        "gimp"
        "jetbrains-toolbox"
        "krita"
        "signal"
        "raycast"
        "karabiner-elements"
        "whichspace"
        "aldente"
        "shottr"
        "onionshare"
        "bitwarden"
        "linearmouse"
        "veracrypt"
        "obsidian"
        "neovide"
        "discord"
        "calibre"
        (skipSha "element")
        (noQuarantine "librewolf")
        (skipSha "megasync")
        (skipSha "spotify")

        # Drivers
        "wacom-tablet"
      ];
    taps = [ "homebrew/services" "homebrew/cask" ];
  };
}
