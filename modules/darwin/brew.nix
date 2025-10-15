_:

{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };
    casks = [
      "1password"
      "anki"
      "arc"
      "arduino-ide"
      "balenaetcher"
      "claude"
      "discord"
      "ghostty"
      "iina"
      "ollama-app"
      "istat-menus"
      "jetbrains-toolbox"
      "jordanbaird-ice"
      "keka"
      "logi-options+"
      "notion"
      "notion-calendar"
      "obsidian"
      "orbstack"
      "rectangle"
      "visual-studio-code"
      "vivaldi"
      "zed"
      "zoom"
    ];
  };
}
