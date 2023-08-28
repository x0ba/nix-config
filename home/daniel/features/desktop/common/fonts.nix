{ pkgs
, lib
, config
, ...
}: {
  home.activation = {
    installCustomFonts =
      let
        fontDirectory =
          if pkgs.stdenv.isDarwin
          then "${config.home.homeDirectory}/Library/Fonts"
          else "${config.xdg.dataHome}/fonts";
        fontPath = ./fonts;
      in
      lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        mkdir -p "${fontDirectory}"
        install -Dm644 ${fontPath}/* "${fontDirectory}"
      '';
  };
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" "Iosevka" "VictorMono" ]; })
    victor-mono
    cascadia-code
    ibm-plex
    dosis
    source-sans-pro
    open-sans
    recursive
    atkinson-hyperlegible
  ];
}
