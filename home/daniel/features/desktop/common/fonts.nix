{ pkgs
, lib
, config
, ...
}: {
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" "Iosevka" "VictorMono" "CascadiaCode" ]; })
    victor-mono
    cascadia-code
    ibm-plex
    dosis
    source-sans-pro
    open-sans
    iosevka
    recursive
    atkinson-hyperlegible
  ];
}
