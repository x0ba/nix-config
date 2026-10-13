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
      "penso/homebrew-tap" = inputs.penso-tap;
    };
  };
  homebrew = {
    enable = true;
    taps = map (
      name:
      if name == "mikker/homebrew-tap" || name == "penso/homebrew-tap" then
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
      "todoist"
      "notion-calendar"
      "wispr-flow"
      "superwhisper"
      # "fluidvoice" trying out the beta rn, will reinstall via brew once it's stable
      "mikker/tap/fst"
      "thebrowsercompany-dia"
      "fuse-t"
      "penso/tap/herdr-gpui"
      "ghostty"
      "google-chrome"
      "granola"
      "imageoptim"
      "intellij-idea"
      "logi-options+"
      "notion"
      "ollama-app"
      "orbstack"
      "github"
      "paper-design"
      "thaw"
      "microsoft-teams"
      "slack"
      "spotify"
      "tailscale-app"
      "veracrypt-fuse-t"
      "visual-studio-code"
      "zed"
      "zoom"
    ];
  };
}
