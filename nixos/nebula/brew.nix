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
        name = "svim";
        start_service = true;
      }
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
        "alfred"
        "bitwarden"
        "blender"
        "discord"
        "docker"
        "firefox"
        "iina"
        "imageoptim"
        "nextcloud"
        "karabiner-elements"
        "obs"
        "postman"
        "rustdesk"
        "uninstallpkg"
        "utm"
        "discord"
        "spotify"
        "neovide"
        "arc"
        "raycast"
        "orion"
        # "font-caskaydia-cove-nerd-font"
        (skipSha "spotify")
        (noQuarantine "vial")
      ];
    taps = [ "homebrew/services" "homebrew/cask" "wez/wezterm" "homebrew/cask-fonts" "FelixKratz/formulae" "cmacrae/formulae" ];
  };
}
