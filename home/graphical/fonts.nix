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
      nur.repos.x0ba.apple-fonts
      nur.repos.x0ba.liga-sfmono
      jetbrains-mono
      ibm-plex
    ];
  };
}
