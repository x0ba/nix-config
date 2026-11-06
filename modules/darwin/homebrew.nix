{ lib, ... }:
{
  environment.systemPath = lib.mkAfter [ "/opt/homebrew/bin" ];

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "uninstall";
    };

    casks = [
      "1password"
      "cleanshot"
      "zoom"
      "paper-design"
      "cursor"
      "tailscale-app"
      "discord"
      "yaak"
      "ghostty"
      "google-chrome"
      "granola"
      "grok-bot"
      "anomalyco/tap/hex"
      "logi-options+"
      "notion"
      "orbstack"
      "raycast"
      "slack"
      "t3-code@nightly"
      "visual-studio-code"
    ];
  };
}
