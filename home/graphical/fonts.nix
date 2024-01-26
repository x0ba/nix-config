{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.isGraphical {
    home.packages = with pkgs; [
      (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
      nur.repos.x0ba.liga-sfmono
      alegreya-sans
      fira
      alegreya
      overpass
    ];
  };
}
