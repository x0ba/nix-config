{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.isGraphical {
    programs.alacritty = {
      enable = true;
      settings = with config.colorScheme.colors; {
        window.padding.x = 20;
        window.padding.y = 20;
        window.decorations = "none";
        mouse.hide_when_typing = true;
        cursor.style = "Beam";
        env.TERM = "xterm-256color";

        font = {
          size = 15;
          normal.family = "Liga SFMono Nerd Font";
          normal.style = "Light";
          bold.family = "Liga SFMono Nerd Font";
          bold.style = "Bold";
          italic.family = "Liga SFMono Nerd Font";
          italic.style = "Italic";
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

        keyboard.bindings = [
          {
            key = "T";
            mods = "Command";
            chars = "\\u0002\\u0063";
          }
          {
            key = "C";
            mods = "Command|Shift";
            chars = "\\u0002\\u0043";
          }
          {
            key = "E";
            mods = "Command";
            chars = "\\u0002\\u0025";
          }
          {
            key = "E";
            mods = "Command|Shift";
            chars = "\\u0002\\u0022";
          }
          {
            key = "G";
            mods = "Command";
            chars = "\\u0002g";
          }
          {
            key = "G";
            mods = "Command|Shift";
            chars = "\\u0002G";
          }
          {
            key = "J";
            mods = "Command";
            chars = "\\u0002\\u0054";
          }
          {
            key = "K";
            mods = "Command";
            chars = "\\u0002\\u0054";
          }
          {
            key = "L";
            mods = "Command";
            chars = "\\u0002L";
          }
          {
            key = "O";
            mods = "Command";
            chars = "\\u0002u";
          }
          {
            key = "V";
            mods = "Command|Shift";
            chars = "\\u0002]";
          }
          {
            key = "W";
            mods = "Command";
            chars = "\\u0002x";
          }
          {
            key = "Z";
            mods = "Command";
            chars = "\\u0002z";
          }
          {
            key = "Comma";
            mods = "Command";
            chars = "\\u0002,";
          }
          {
            key = "LBracket";
            mods = "Command|Shift";
            chars = "\\u0002p";
          }
          {
            key = "RBracket";
            mods = "Command|Shift";
            chars = "\\u0002n";
          }
          {
            key = "Key1";
            mods = "Command";
            chars = "\\u00021";
          }
          {
            key = "Key2";
            mods = "Command";
            chars = "\\u00022";
          }
          {
            key = "Key3";
            mods = "Command";
            chars = "\\u00023";
          }
          {
            key = "Key4";
            mods = "Command";
            chars = "\\u00024";
          }
          {
            key = "Key5";
            mods = "Command";
            chars = "\\u00025";
          }
          {
            key = "Key6";
            mods = "Command";
            chars = "\\u00026";
          }
          {
            key = "Key7";
            mods = "Command";
            chars = "\\u00027";
          }
          {
            key = "Key8";
            mods = "Command";
            chars = "\\u00028";
          }
          {
            key = "Key9";
            mods = "Command";
            chars = "\\u00029";
          }
        ];
      };
    };
  };
}
