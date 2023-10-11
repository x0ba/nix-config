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
      "uninstallpkg"
      "nextcloud"
      "qbittorrent"
      "anki"
      "maccy"
      "dash"
      "imageoptim"
      "ticktick"
      "protonvpn"
      "stats"
      "lulu"
      "obs"
      "appcleaner"
      "rustdesk"
      "skiff"
      "aldente"
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
      (skipSha "element")
      (skipSha "spotify")

      # Drivers
      "wacom-tablet"
      (skipSha "logitech-options")
    ];
    taps = ["homebrew/services" "homebrew/cask" "d12frosted/emacs-plus"];
  };
}
