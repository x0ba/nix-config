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
        "amethyst"
        "1password"
        "vivaldi"
        "stats"
        "tor-browser"
        "pomodone"
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
    ];
    taps = [ "homebrew/services" "d12frosted/emacs-plus" "homebrew/cask" "homebrew/cask-fonts" "FelixKratz/formulae" "cmacrae/formulae" ];
  };
}
