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
    (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
    inter
    nur.repos.x0ba.monaspace
    ibm-plex
    recursive
    hack-font
    cascadia-code
    iosevka
    atkinson-hyperlegible
  ];
}
