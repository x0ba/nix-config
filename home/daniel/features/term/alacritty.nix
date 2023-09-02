{ config, ... }:
let
  theme = config.colorScheme;
in
{
  programs.alacritty = {
    enable = true;
    settings = with theme.colors; {
      window.padding.x = 15;
      window.padding.y = 10;
      window.dynamic_padding = true;
      window.decorations = "none";
      mouse.hide_when_typing = true;
      use_thin_strokes = true;
      cursor.style = "Block";

      font = {
        size = 17.5;
        normal.family = "Iosevka Nerd Font";
        normal.style = "Regular";
        bold.family = "Iosevka Nerd Font";
        bold.style = "Bold";
        italic.family = "Iosevka Nerd Font";
        italic.style = "Italic";
        offset.x = 0;
        offset.y = 5;
        glyph_offset.x = 0;
        glyph_offset.y = 3;
        builtin_box_drawing = true;
      };

      key_bindings = [
        {
          key = "T";
          mods = "Command";
          chars = "\\x01\\x63";
        }
        {
          key = "W";
          mods = "Command";
          chars = "\\x01x";
        }
        {
          key = "Z";
          mods = "Command";
          chars = "\\x01z";
        }
        {
          key = "Key1";
          mods = "Command";
          chars = "\\x011";
        }
        {
          key = "Key2";
          mods = "Command";
          chars = "\\x012";
        }
        {
          key = "Key3";
          mods = "Command";
          chars = "\\x013";
        }
        {
          key = "Key4";
          mods = "Command";
          chars = "\\x014";
        }
        {
          key = "Key5";
          mods = "Command";
          chars = "\\x015";
        }
        {
          key = "Key6";
          mods = "Command";
          chars = "\\x016";
        }
        {
          key = "E";
          mods = "Command";
          chars = "\\x01|";
        }
        {
          key = "E";
          mods = "Command|Shift";
          chars = "\\x01-";
        }
        {
          key = "J";
          mods = "Command";
          chars = "\\x01\\x54";
        }
      ];

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
