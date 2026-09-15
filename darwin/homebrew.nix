{ inputs, config, ... }: {
  nix-homebrew = {
    enable = true;
    user = "daniel";
    autoMigrate = true;
    enableRosetta = false;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    mutableTaps = false;
    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
    };
  };
  homebrew = {
    enable = true;
    taps = builtins.attrNames config.nix-homebrew.taps;
    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "zap";
    };
    casks = [
      "chatgpt"
      "raycast"
      "grok-bot"
      "t3-code@nightly"
      "1password"
      "adobe-creative-cloud"
      "balenaetcher"
      "blip"
      "cleanshot"
      "cmux"
      "cursor"
      "discord"
      "fluidvoice"
      "fuse-t"
      "ghostty"
      "google-chrome"
      "granola"
      "helium-browser"
      "homebrew-app"
      "imageoptim"
      "intellij-idea"
      "logi-options+"
      "notion"
      "notion-calendar"
      "ollama-app"
      "orbstack"
      "paper-design"
      "pycharm"
      "slack"
      "spotify"
      "tailscale-app"
      "thaw"
      "veracrypt-fuse-t"
      "visual-studio-code"
      "wispr-flow"
      "zed"
      "zoom"
    ];
  };
}
