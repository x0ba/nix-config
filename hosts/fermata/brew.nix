{config, ...}: let
  skipSha = name: {
    inherit name;
    args.require_sha = false;
  };
in {
  # make brew available in PATH
  environment.systemPath = [config.homebrew.brewPrefix];

  homebrew = {
    enable = true;
    caskArgs.require_sha = true;
    brews = [
      "podman"
      "gnu-sed"
      "bitwarden-cli"
    ];
    taps = [
      "d12frosted/emacs-plus"
      "homebrew/services"
    ];
    casks = [
      "1password"
      "appcleaner"
      "bettertouchtool"
      "alt-tab"
      "brave-browser"
      "element"
      "keepassxc"
      "karabiner-elements"
      "firefox"
      "lulu"
      "discord"
      "calibre"
      "grandperspective"
      "tailscale"
      "linearmouse"
      "shottr"
      "iina"
      "jetbrains-toolbox"
      "keka"
      "mac-mouse-fix"
      "shottr"
      "protonvpn"
      "latest"
      "mullvad-browser"
      "netnewswire"
      "notion-calendar"
      "obsidian"
      "syncthing"
      "qbittorrent"
      "raycast"
      "tor-browser"
      "wacom-tablet"
      "yubico-yubikey-manager"
      "yubico-authenticator"
      "zed"
      (skipSha "spotify")
    ];
    onActivation = {
      autoUpdate = true;
      upgrade = true;
    };
  };
}
