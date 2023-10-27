{pkgs, ...}: {
  stylix = {
    image = ../wallpapers/262626.png;
    autoEnable = false;
    targets = {
      bat.enable = true;
      alacritty.enable = true;
      zellij.enable = true;
      wezterm.enable = true;
    };
    fonts = {
      monospace = {
        name = "IBM Plex Mono";
        # need to write a dummy font since berkeley mono isnt in nixpkgs
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
      base00 = "#0c0e0f";
      base01 = "#121415";
      base02 = "#161819";
      base03 = "#1f2122";
      base04 = "#27292a";
      base05 = "#edeff0";
      base06 = "#e4e6e7";
      base07 = "#f2f4f5";
      base08 = "#f26e74";
      base09 = "#ecd28b";
      base0A = "#e79881";
      base0B = "#82c29c";
      base0C = "#6791C9";
      base0D = "#709ad2";
      base0E = "#c58cec";
      base0F = "#e8646a";
    };
  };
}
