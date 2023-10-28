{pkgs, ...}: {
  stylix = {
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
        name = "Iosevka Nerd Font";
        package = pkgs.nerdfonts.override {fonts = ["Iosevka"];};
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
  home.mac-wallpaper = ../theme/oxocarbon/wall.png;
}
