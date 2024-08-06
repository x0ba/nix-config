{
  pkgs,
  config,
  lib,
  ...
}:
{
  options = {
    fonts.enable = lib.mkEnableOption "enables fonts";
  };

  config = lib.mkIf config.fonts.enable {
    home.activation.installCustomFonts =
      let
        fontDirectory =
          if pkgs.stdenv.isDarwin then
            "${config.home.homeDirectory}/Library/Fonts"
          else
            "${config.xdg.dataHome}/fonts";
        fontPath = ./fonts;
      in

      lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        mkdir -p "${fontDirectory}"
        install -Dm644 ${fontPath}/* "${fontDirectory}"
      '';
    home.packages = with pkgs; [
      (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
      ibm-plex
      alegreya
      inter
      atkinson-hyperlegible
    ];
  };
}
