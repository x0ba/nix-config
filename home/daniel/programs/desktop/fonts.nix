{ config
, lib
, pkgs
, ...
}: {
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" "Iosevka" ]; })
    victor-mono
    ibm-plex
    cozette
    dosis
    roboto
    iosevka
    recursive
  ];
}
