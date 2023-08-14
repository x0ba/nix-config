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
        "iina"
        "nuclear"
        "brave-browser"
        "foobar2000"
        "amethyst"
        "docker"
        "1password"
        "vivaldi"
        "textual"
        "vivaldi"
        "stats"
        "tor-browser"
        "rectangle"
        "utm"
        "mullvad-browser"
        (skipSha "spacelauncher")
        (skipSha "affinity-designer")
        (skipSha "affinity-photo")
        (noQuarantine "easy-move-plus-resize")
        (skipSha "affinity-publisher")
        (skipSha "element")
        (skipSha "craft")
        (skipSha "flow")
        (skipSha "steam")
        (skipSha "roam-research")
        (noQuarantine "librewolf")
        "logseq"
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

        # Drivers
        "wacom-tablet"
      ];

    brews = [
      # {
      #   name = "sketchybar";
      #   start_service = false;
      # }
      {
        name = "python3";
      }
    ];
    taps = [ "homebrew/services" "d12frosted/emacs-plus" "homebrew/cask" "homebrew/cask-fonts" "FelixKratz/formulae" "cmacrae/formulae" ];
  };
}
