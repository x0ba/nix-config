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
      "mikker/homebrew-tap" = inputs.mikker-tap;
      "saragordic/homebrew-tap" = inputs.saragordic-tap;
    };
  };
  homebrew = {
    enable = true;
    taps = map (
      name:
      if name == "mikker/homebrew-tap" || name == "saragordic/homebrew-tap" then
        {
          inherit name;
          # Homebrew 6 skips casks from untrusted third-party taps.
          trusted = true;
        }
      else
        name
    ) (builtins.attrNames config.nix-homebrew.taps);
    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "zap";
    };
    casks = [
      "chatgpt"
      "raycast"
      "grok-bot"
      "1password"
      "adobe-creative-cloud"
      "blip"
      "cleanshot"
      "cursor"
      "discord"
      "notion-calendar"
      # "fluidvoice" trying out the beta rn, will reinstall via brew once it's stable
      "mikker/tap/fst"
      "fuse-t"
      "ghostty"
      "google-chrome"
      "granola"
      "imageoptim"
      "intellij-idea"
      "logi-options+"
      "notion"
      "ollama-app"
      "orbstack"
      "paper-design"
      "saragordic/tap/rooms"
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
