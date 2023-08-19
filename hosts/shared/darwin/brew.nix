{
  homebrew = {
    enable = true;
    caskArgs.require_sha = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };
    casks =
      let
        skipSha = name: {
          inherit name;
          args = { require_sha = false; };
        };
      in
      [
        "firefox"
        "stats"
        "soulseek"
        "brave-browser"
        "flux"
        "iina"
        "amethyst"
        "dozer"
        "1password"
        "whichspace"
        "borg-wrapper"
        "appcleaner"
        "textual"
        "signal"
        "tor-browser"
        "utm"
        (skipSha "element")
        "logseq"
        "macfuse"
        "wacom-tablet"
        "uninstallpkg"
        "keka"
        "syncthing"
        "gimp"
        "jetbrains-toolbox"
        "krita"
        "arc"
        "raycast"
        "karabiner-elements"
        "qbittorrent"
        "orion"
        "linearmouse"
        "obsidian"
        "neovide"
        "discord"
        "calibre"
      ];

    brews = [
      {
        name = "svim";
        start_service = true;
      }
      {
        name = "borgbackup-fuse";
      }
      {
        name = "python3";
      }
    ];
    taps = [ "homebrew/services" "d12frosted/emacs-plus" "homebrew/cask" "homebrew/cask-fonts" "FelixKratz/formulae" "cmacrae/formulae" "borgbackup/tap" "sunknudsen/tap" ];
  };
}
