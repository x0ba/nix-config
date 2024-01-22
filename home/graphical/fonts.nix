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
      fira-code
      nur.repos.x0ba.liga-sfmono
      alegreya-sans
      alegreya
      emacs-all-the-icons-fonts
      overpass
      inter
      ibm-plex
    ];
  };
}
