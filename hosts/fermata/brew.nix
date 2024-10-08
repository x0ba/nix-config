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
      "firefox"
      "hiddenbar"
      "iina"
      "jetbrains-toolbox"
      "prismlauncher"
      "kap"
      "keepassxc"
      "keka"
      "krita"
      "macfuse"
      "knockknock"
      "ransomwhere"
      "mullvad-browser"
      "obsidian"
      "linearmouse"
      "utm"
      "onionshare"
      "protonvpn"
      "tor-browser"
      "raycast"
      "selfcontrol"
      "shottr"
      "sublime-merge"
      "sublime-text"
      "syncthing"
      "veracrypt"
      "visual-studio-code"
      "wacom-tablet"
      "yubico-authenticator"
      "yubico-yubikey-manager"
      "zed"
      (skipSha "istat-menus")
      (skipSha "alienator88/homebrew-cask/pearcleaner")
      (skipSha "spotify")
      (skipSha "onyx")
      (noQuarantine "hiddenbar")
    ];
    onActivation = {
      autoUpdate = true;
      upgrade = true;
    };
  };
}
