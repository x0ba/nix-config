{
  homebrew = {
    enable = true;
    caskArgs.require_sha = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };
    brews = [
      # {
      #   name = "sketchybar";
      #   start_service = true;
      # }
      {
        name = "libiconv";
      }
    ];
    casks = [
      "ticktick"
      "firefox"
      "arc"
      "calibre"
    ];
    taps = ["homebrew/services" "d12frosted/emacs-plus" "homebrew/cask" "homebrew/cask-fonts" "FelixKratz/formulae" "cmacrae/formulae"];
  };
}
