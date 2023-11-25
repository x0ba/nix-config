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
    nur.repos.x0ba.inter
    lexend
    manrope
    nur.repos.x0ba.ia-writer-quattro
    cascadia-code
    ibm-plex
    maple-mono
    iosevka-comfy.comfy
  ];
}
