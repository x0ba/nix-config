{ config, ... }:
let
  noQuarantine = name: {
    inherit name;
    args.no_quarantine = true;
  };
  skipSha = name: {
    inherit name;
    args.require_sha = false;
  };
in
{
  # make brew available in PATH
  environment.systemPath = [ config.homebrew.brewPrefix ];

  homebrew = {
    enable = true;
    caskArgs.require_sha = true;
    taps = [
      "borgbackup/tap"
      "homebrew/services"
    ];
    brews = [ "borgbackup-fuse" ];
    casks = [
      "bettertouchtool"
      "brave-browser"
      "calibre"
      "sublime-text"
      "iterm2"
      "sublime-merge"
      "iina"
      "jetbrains-toolbox"
      "hiddenbar"
      "keepassxc"
      "keka"
      "macfuse"
      "mullvad-browser"
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
      (skipSha "spotify")
      (noQuarantine "hiddenbar")
    ];
    onActivation = {
      autoUpdate = true;
      upgrade = true;
    };
  };
}
