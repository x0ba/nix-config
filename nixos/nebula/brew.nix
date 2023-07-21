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
        "bitwarden"
        "blender"
        "discord"
        "docker"
        "firefox"
        "iina"
        "sf-symbols"
        "imageoptim"
        "nextcloud"
        "mullvad-browser"
        "calibre"
        "jetbrains-toolbox"
        "karabiner-elements"
        "obs"
        "linearmouse"
        "uninstallpkg"
        "utm"
        "discord"
        "eloston-chromium"
        "raycast"
        "spotify"
        "neovide"
        "arc"
        "orion"
        # "font-caskaydia-cove-nerd-font"
        (skipSha "spotify")
        (skipSha "tutanota")
      ];
    taps = [ "homebrew/services" "homebrew/cask" "homebrew/cask-fonts" "FelixKratz/formulae" "cmacrae/formulae" ];
  };
}
