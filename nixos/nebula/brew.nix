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
      # {
      #   name = "sketchybar";
      #   start_service = false;
      # }
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
      "bitwarden"
      "opera"
      "notion"
      "discord"
      "vscodium"
      "docker"
      "dozer"
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
      # "font-caskaydia-cove-nerd-font"
      (skipSha "spotify")
      (skipSha "tutanota")
    ];
    taps = ["homebrew/services" "d12frosted/emacs-plus" "homebrew/cask" "homebrew/cask-fonts" "FelixKratz/formulae" "cmacrae/formulae"];
  };
}
