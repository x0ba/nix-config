{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  programs.alacritty = {
    enable = true;
    settings = with config.lib.stylix.colors; {
      window.padding.x = 45;
      window.padding.y = 45;
      window.decorations = "none";
      mouse.hide_when_typing = true;
      use_thin_strokes = true;
      cursor.style = "Beam";

      font = {
        size = 15;
        normal.family = "JetBrainsMono Nerd Font";
        normal.style = "Normal";
        bold.family = "JetBrainsMono Nerd Font";
        bold.style = "Bold";
        italic.family = "JetBrainsMono Nerd Font";
        italic.style = "Italic";
        offset = {
          x = 0;
          y = 5;

          glyph_offset = {
            x = 0;
            y = 3;
          };
        };
      };

      colors = {
        cursor.cursor = "#${base04}";
        primary.background = "#${base00}";
        primary.foreground = "#${base06}";
        normal = {
          black = "#${base00}";
          red = "#${base0B}";
          green = "#${base0C}";
          yellow = "#${base0D}";
          blue = "#${base07}";
          magenta = "#${base0F}";
          cyan = "#${base09}";
          white = "#${base04}";
        };
        bright = {
          black = "#${base03}";
          red = "#${base0B}";
          green = "#${base0C}";
          yellow = "#${base0D}";
          blue = "#${base07}";
          magenta = "#${base0F}";
          cyan = "#${base09}";
          white = "#${base06}";
        };
      };
    };
  };
}
