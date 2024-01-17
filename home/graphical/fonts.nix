{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.isGraphical {
    home.packages = with pkgs; [
      (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
      ia-writer-quattro
      jetbrains-mono
      iosevka
      inter
      ibm-plex
      dosis
    ];
  };
}
