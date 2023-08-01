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
        name = "emacs-plus";
        start_service = true;
      }
    ];
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
      "notion"
      "ticktick"
      "uninstallpkg"
      "discord"
      "vscodium"
      "obsidian"
      "docker"
      "firefox"
      "iina"
      "imageoptim"
      "neovide"
      "nextcloud"
      "calibre"
      "karabiner-elements"
      "linearmouse"
      "discord"
      "eloston-chromium"
      "raycast"
      "spotify"
      "arc"
      "orion"
    ];
    taps = ["homebrew/services" "d12frosted/emacs-plus" "homebrew/cask" "homebrew/cask-fonts" "FelixKratz/formulae" "cmacrae/formulae"];
  };
}
