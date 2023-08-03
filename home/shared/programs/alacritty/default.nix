{config, ...}: let
  theme = config.colorScheme;
in {
  programs.alacritty = {
    enable = true;
    settings = with theme.colors; {
      window.padding.x = 25;
      window.padding.y = 25;
      window.decorations = "none";
      mouse.hide_when_typing = true;
      use_thin_strokes = true;
      cursor.style = "Beam";

      font = {
        size = 17;
        normal.family = "Fairfax";
        normal.style = "Medium";
        bold.family = "Fairfax";
        bold.style = "Bold";
        italic.family = "Fairfax";
        italic.style = "Italic";
      };

      colors = with theme.colors; {
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
