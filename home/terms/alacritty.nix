{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.isGraphical {
    programs.alacritty = {
      enable = true;
      settings = with config.colorScheme.colors; {
        window.padding.x = 45;
        window.padding.y = 45;
        window.decorations = "buttonless";
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

        shell.program = "${pkgs.fish}/bin/fish";

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
  };
}
