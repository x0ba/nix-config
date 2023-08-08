{
  homebrew = {
    enable = true;
    caskArgs.require_sha = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };
    brews = [
      {
        name = "sketchybar";
        start_service = true;
      }
    ];
    casks = [
      "firefox"
      "brave-browser"
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
    ];
    taps = [ "homebrew/services" "d12frosted/emacs-plus" "homebrew/cask" "homebrew/cask-fonts" "FelixKratz/formulae" "cmacrae/formulae" ];
  };
}
