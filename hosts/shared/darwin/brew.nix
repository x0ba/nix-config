{
  homebrew = {
    enable = true;
    caskArgs.require_sha = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };
    casks = let
      skipSha = name: {
        inherit name;
        args = {require_sha = false;};
      };
      noQuarantine = name: {
        inherit name;
        args = {no_quarantine = true;};
      };
    in [
      "firefox"
      "stats"
      "soulseek"
      "brave-browser"
      "iina"
      "lulu"
      "amethyst"
      "hiddenbar"
      "1password"
      "whichspace"
      "appcleaner"
      "textual"
      "signal"
      "tor-browser"
      "vorta"
      "utm"
      (skipSha "element")
      (noQuarantine "librewolf")
      "logseq"
      "itsycal"
      "macfuse"
      "wacom-tablet"
      "uninstallpkg"
      "keka"
      "syncthing"
      "gimp"
      "jetbrains-toolbox"
      "krita"
      "arc"
      "raycast"
      "karabiner-elements"
      "qbittorrent"
      "orion"
      "linearmouse"
      "obsidian"
      "neovide"
      "discord"
      "calibre"
    ];

    brews = [
      {
        name = "python3";
      }
    ];
    taps = ["homebrew/services" "homebrew/cask"];
  };
}
