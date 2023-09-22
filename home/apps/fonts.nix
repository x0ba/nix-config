{
  pkgs,
  lib,
  config,
  ...
}: {
  home.packages = with pkgs; [
    (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly" "Iosevka" "JetBrainsMono"];})
    victor-mono
    ankacoder
    ibm-plex
    maple-mono
    dosis
    recursive
    atkinson-hyperlegible
  ];
}
