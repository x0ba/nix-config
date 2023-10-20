{
  pkgs,
  lib,
  config,
  ...
}: {
  home.activation = {
    installCustomFonts = let
      fontDirectory =
        if pkgs.stdenv.isDarwin
        then "${config.home.homeDirectory}/Library/Fonts"
        else "${config.xdg.dataHome}/fonts";
      fontPath = ./../secrets/fonts;
    in
      lib.hm.dag.entryAfter ["writeBoundary"] ''
        mkdir -p "${fontDirectory}"
        install -Dm644 ${fontPath}/* "${fontDirectory}"
      '';
  };
  home.packages = with pkgs; [
    (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly" "CascadiaCode" "Iosevka" "JetBrainsMono" "VictorMono"];})
    ibm-plex
    terminus_font_ttf
    iosevka
    cozette
    maple-mono
    fira-code
    inter
    cascadia-code
    dosis
    recursive
    atkinson-hyperlegible
  ];
}
