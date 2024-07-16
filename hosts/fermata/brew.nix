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
      "borgbackup-fuse"
    ];
    casks = [
      "bettertouchtool"
      "brave-browser"
      "keepassxc"
      "calibre"
      "veracrypt"
      "protonvpn"
      "visual-studio-code"
      "shottr"
      "iina"
      "selfcontrol"
      "jetbrains-toolbox"
      "macfuse"
      "keka"
      "mullvad-browser"
      "obsidian"
      "syncthing"
      "raycast"
      "wacom-tablet"
      "yubico-yubikey-manager"
      "yubico-authenticator"
      "zed"
      (skipSha "alienator88/homebrew-cask/pearcleaner")
    ];
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
  };
}
