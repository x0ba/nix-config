{pkgs, ...}: {
  stylix = {
    image = ../wallpapers/262626.png;
    autoEnable = false;
    targets = {
      bat.enable = true;
      tmux.enable = true;
      fish.enable = true;
      zellij.enable = true;
      wezterm.enable = true;
    };
    fonts = {
      monospace = {
        name = "IBM Plex Mono";
        package = pkgs.ibm-plex;
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
    base16Scheme = {
      base00 = "161616";
      base01 = "262626";
      base02 = "393939";
      base03 = "525252";
      base04 = "dde1e6";
      base05 = "f2f4f8";
      base06 = "ffffff";
      base07 = "08bdba";
      base08 = "3ddbd9";
      base09 = "78a9ff";
      base0A = "ee5396";
      base0B = "33b1ff";
      base0C = "ff7eb6";
      base0D = "42be65";
      base0E = "be95ff";
      base0F = "82cfff";
    };
  };
}
