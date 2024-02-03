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
      emacs-all-the-icons-fonts
      alegreya-sans
      ibm-plex
      fira
      fira-code
      alegreya
      overpass
    ];
  };
}
