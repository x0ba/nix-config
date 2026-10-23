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
      "balenaetcher"
      "bambu-studio"
      "aside"
      "claude"
      "cleanshot"
      "zoom"
      "cursor"
      "tailscale"
      "discord"
      "fluidvoice"
      "ghostty"
      "google-chrome"
      "granola"
      "grok-bot"
      "homebrew-app"
      "istat-menus"
      "logi-options+"
      "ngrok"
      "notion"
      "notion-calendar"
      "orbstack"
      "raycast"
      "slack"
      "spotify"
      "t3-code@nightly"
      "todoist-app"
      "visual-studio-code"
      "zed"
    ];
  };
}
