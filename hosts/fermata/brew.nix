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
    taps = [
      "borgbackup/tap"
    ];
    brews = [
      "bitwarden-cli"
      "borgbackup-fuse"
    ];
    casks = [
      "appcleaner"
      "bettertouchtool"
      "bitwarden"
      "element"
      "brave-browser"
      "firefox"
      "pictogram"
      "lulu"
      "discord"
      "keepassxc"
      "calibre"
      "grandperspective"
      "tailscale"
      "veracrypt"
      "iterm2"
      "linearmouse"
      "shottr"
      "iina"
      "ticktick"
      "selfcontrol"
      "jetbrains-toolbox"
      "macfuse"
      "keka"
      "latest"
      "mullvad-browser"
      "netnewswire"
      "obsidian"
      "syncthing"
      "raycast"
      "tor-browser"
      "wacom-tablet"
      "chatgpt"
      "yubico-yubikey-manager"
      "yubico-authenticator"
      "zed"
      (skipSha "spotify")
      (skipSha "steam")
    ];
    onActivation = {
      autoUpdate = true;
      upgrade = true;
    };
  };
}
