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
      "homebrew/services"
    ];
    brews = [
      "borgbackup-fuse"
      "php"
    ];
    casks = [
      "bettertouchtool"
      "brave-browser"
      "calibre"
      "sublime-text"
      "iterm2"
      "jordanbaird-ice"
      "sublime-merge"
      "iina"
      "jetbrains-toolbox"
      "keepassxc"
      "keka"
      "macfuse"
      "mullvad-browser"
      "santa"
      "obsidian"
      "protonvpn"
      "raycast"
      "selfcontrol"
      "shottr"
      "syncthing"
      "veracrypt"
      "visual-studio-code"
      "wacom-tablet"
      "yubico-authenticator"
      "yubico-yubikey-manager"
      "zed"
      (skipSha "alienator88/homebrew-cask/pearcleaner")
    ];
    onActivation = {
      autoUpdate = true;
      upgrade = true;
    };
  };
}
