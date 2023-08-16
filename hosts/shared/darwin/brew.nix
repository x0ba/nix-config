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
    in [
      "firefox"
      "soulseek"
      "iina"
      "amethyst"
      "dozer"
      "1password"
      "whichspace"
      "appcleaner"
      "textual"
      "tor-browser"
      "utm"
      "mullvad-browser"
      (skipSha "element")
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
    taps = ["homebrew/services" "d12frosted/emacs-plus" "homebrew/cask" "homebrew/cask-fonts" "FelixKratz/formulae" "cmacrae/formulae"];
  };
}
