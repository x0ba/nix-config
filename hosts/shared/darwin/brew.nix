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
        "stats"
        "soulseek"
        "brave-browser"
        "iina"
        "lulu"
        "amethyst"
        "hiddenbar"
        "1password"
        (skipSha "megasync")
        "rectangle"
        "easy-move-plus-resize"
        "appcleaner"
        "skiff"
        "alt-tab"
        "nova"
        "anki"
        "tor-browser"
        "macfuse"
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
        (skipSha "element")

        # Drivers
        "wacom-tablet"
      ];

    brews = [
      {
        name = "python3";
      }
    ];
    taps = [ "homebrew/services" "homebrew/cask" ];
  };
}
