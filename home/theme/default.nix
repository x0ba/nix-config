{pkgs, ...}: {
  stylix = {
    image = ../theme/yoru/wall.png;
    autoEnable = false;
    targets = {
      bat.enable = true;
      alacritty.enable = true;
      fish.enable = true;
      zellij.enable = true;
      wezterm.enable = true;
    };
    fonts = {
      monospace = {
        name = "Iosevka";
        package = pkgs.iosevka;
      };
      emoji = {
        name = "Symbols Nerd Font";
        package = pkgs.nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];};
      };
      sansSerif = {
        name = "IBM Plex Sans";
        package = pkgs.ibm-plex;
      };
    };
    base16Scheme = import ./yoru;
  };
}
