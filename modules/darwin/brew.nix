_: {
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
      "logi-options+"
      "iina"
      "ollama-app"
      "istat-menus"
      "jetbrains-toolbox"
      "jordanbaird-ice@beta"
      "keka"
      "prismlauncher"
      "lunar-client"
      "notion"
      "notion-calendar"
      "obsidian"
      "orbstack"
      "steam"
      "yubico-authenticator"
      "rectangle"
      "vivaldi"
      "zed"
      "zoom"
    ];
  };
}
