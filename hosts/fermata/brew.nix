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
      "bettertouchtool"
      "bitwarden"
      "element"
      "brave-browser"
      "pictogram"
      "lulu"
      "discord"
      "keepassxc"
      "calibre"
      "grandperspective"
      "tailscale"
      "veracrypt"
      "linearmouse"
      "shottr"
      "iina"
      "selfcontrol"
      "jetbrains-toolbox"
      "macfuse"
      "keka"
      "knockknock"
      "blockblock"
      "ransomwhere"
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
      (skipSha "alienator88/homebrew-cask/pearcleaner")
    ];
    onActivation = {
      autoUpdate = true;
      upgrade = true;
    };
  };
}
