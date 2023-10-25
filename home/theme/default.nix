{pkgs, ...}: {
  stylix = {
    image = ../wallpapers/262626.png;
    autoEnable = false;
    targets = {
      bat.enable = true;
      fish.enable = true;
      zellij.enable = true;
      # wezterm.enable = true;
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
      base00 = "1e1e2e";
      base01 = "181825";
      base02 = "313244";
      base03 = "45475a";
      base04 = "585b70";
      base05 = "cdd6f4";
      base06 = "f5e0dc";
      base07 = "b4befe";
      base08 = "f38ba8";
      base09 = "fab387";
      base0A = "f9e2af";
      base0B = "a6e3a1";
      base0C = "94e2d5";
      base0D = "89b4fa";
      base0E = "cba6f7";
      base0F = "f2cdcd";
    };
  };
}
