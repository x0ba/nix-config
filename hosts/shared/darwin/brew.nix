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
      in
      [
        "firefox"
        "brave-browser"
        "tor-browser"
        "utm"
        (skipSha "affinity-designer")
        (skipSha "affinity-photo")
        (skipSha "affinity-publisher")
        (skipSha "element")
        (skipSha "flow")
        "uninstallpkg"
        "keka"
        "syncthing"
        "gimp"
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
      {
        name = "sketchybar";
        start_service = true;
      }
      {
        name = "emacs-plus@28";
        args = ["with-native-comp"];
        start_service = true;
      }
    ];
    taps = [ "homebrew/services" "d12frosted/emacs-plus" "homebrew/cask" "homebrew/cask-fonts" "FelixKratz/formulae" "cmacrae/formulae" ];
  };
}
