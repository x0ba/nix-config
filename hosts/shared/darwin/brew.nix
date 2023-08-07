{
  homebrew = {
    enable = true;
    caskArgs.require_sha = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };
    casks = [
      "firefox"
      "arc"
      "raycast"
      "karabiner-elements"
      "orion"
      "linearmouse"
      "obsidian"
      "neovide"
      "discord"
      "calibre"
    ];
    taps = ["homebrew/services" "d12frosted/emacs-plus" "homebrew/cask" "homebrew/cask-fonts" "FelixKratz/formulae" "cmacrae/formulae"];
  };
}
