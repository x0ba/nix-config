{ lib, ... }:
{
  # Keeps `brew` and cask CLIs (ngrok, etc.) on PATH, after the Nix paths so
  # Nix versions always win.
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
      "aside"
      "balenaetcher"
      "bambu-studio"
      "cleanshot"
      "cursor"
      "discord"
      "fluidvoice"
      "ghostty"
      "google-chrome"
      "granola"
      "grok-bot"
      "homebrew-app"
      "logi-options+"
      "ngrok"
      "notion"
      "notion-calendar"
      "orbstack"
      "raycast"
      "slack"
      "spotify"
      "t3-code@nightly"
      "thebrowsercompany-dia"
      "todoist-app"
      "visual-studio-code"
      "zed"
    ];
  };
}
