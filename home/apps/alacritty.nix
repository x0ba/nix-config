{
  lib,
  config,
  ...
}: {
  programs.alacritty = {
    enable = true;
    settings = with config.lib.stylix.colors; {
      window.padding.x = 25;
      window.padding.y = 25;
      window.decorations = "none";
      mouse.hide_when_typing = true;
      use_thin_strokes = true;
      cursor.style = "Beam";

      font = {
        size = 15;
        normal.family = "Maple Mono NF";
        bold.family = "Maple Mono NF";
        italic.family = "Maple Mono NF";
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
