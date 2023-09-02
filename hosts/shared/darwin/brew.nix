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
        "soulseek"
        "brave-browser"
        "mullvad-browser"
        "iina"
        "lulu"
        "amethyst"
        "dozer"
        "vorta"
        "appcleaner"
        "skiff"
        "alt-tab"
        "anki"
        "tor-browser"
        "macfuse"
        "uninstallpkg"
        "keka"
        "syncthing"
        "gimp"
        "jetbrains-toolbox"
        "easy-move-plus-resize"
        "rocket"
        "krita"
        "arc"
        "raycast"
        "karabiner-elements"
        "qbittorrent"
        "bitwarden"
        "rectangle"
        "1password"
        "aldente"
        "shottr"
        "linearmouse"
        "obsidian"
        "neovide"
        "discord"
        "calibre"
        (skipSha "element")
        (skipSha "megasync")
        (skipSha "spotify")
        (skipSha "hazeover")

        # Drivers
        "wacom-tablet"
      ];
    taps = [ "homebrew/services" "homebrew/cask" ];
  };
}
