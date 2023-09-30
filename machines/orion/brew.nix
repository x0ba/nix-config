{config, ...}: {
  environment.systemPath = [config.homebrew.brewPrefix];
  homebrew = {
    enable = true;
    caskArgs.require_sha = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };
    brews = [
      # for alfred workflows
      "php"
    ];
    casks = let
      noQuarantine = name: {
        inherit name;
        args = {no_quarantine = true;};
      };
      skipSha = name: {
        inherit name;
        args = {require_sha = false;};
      };
    in [
      "firefox"
      "textual"
      "qbittorrent"
      "anki"
      "maccy"
      "dash"
      "imageoptim"
      "ticktick"
      "protonvpn"
      "stats"
      "lulu"
      "hiddenbar"
      "obs"
      "appcleaner"
      "rustdesk"
      "skiff"
      "1password"
      "macfuse"
      "gimp"
      "jetbrains-toolbox"
      "krita"
      "raycast"
      "iina"
      "polypane"
      "karabiner-elements"
      "orion"
      "shottr"
      "linearmouse"
      "veracrypt"
      "obsidian"
      "discord"
      "calibre"
      (skipSha "battery-buddy")
      (skipSha "element")
      (skipSha "filen")

      # Drivers
      "wacom-tablet"
      (skipSha "logitech-options")
    ];
    taps = ["homebrew/services" "homebrew/cask" "d12frosted/emacs-plus"];
  };
}
