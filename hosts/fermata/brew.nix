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
      "lulu"
      "keepassxc"
      "calibre"
      "sublime-text"
      "grandperspective"
      "tailscale"
      "veracrypt"
      "omnifocus"
      "linearmouse"
      "visual-studio-code"
      "shottr"
      "iina"
      "selfcontrol"
      "jetbrains-toolbox"
      "macfuse"
      "keka"
      "ransomwhere"
      "latest"
      "mullvad-browser"
      "netnewswire"
      "obsidian"
      "syncthing"
      "raycast"
      "tor-browser"
      "wacom-tablet"
      "yubico-yubikey-manager"
      "yubico-authenticator"
      "zed"
      (skipSha "steam")
      (skipSha "alienator88/homebrew-cask/pearcleaner")
    ];
    onActivation = {
      autoUpdate = true;
      upgrade = true;
    };
  };
}
