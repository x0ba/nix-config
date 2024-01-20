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
      fira-code
      nur.repos.x0ba.liga-sfmono
      alegreya-sans
      overpass
      inter
      ibm-plex
    ];
  };
}
