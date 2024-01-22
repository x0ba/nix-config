{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.isGraphical {
    programs.ghostty = {
      enable = true;
      settings = with config.colorScheme.colors; {
        font-family = "Liga SFMono Nerd Font";
        command = "${pkgs.fish}/bin/fish";
        window-inherit-working-directory = true;
        unfocused-split-opacity = 0.96;
        font-size = 15;
        window-theme = "dark";
        confirm-close-surface = false;
        macos-option-as-alt = true;
        mouse-hide-while-typing = true;
        cursor-style = "bar";
        cursor-style-blink = true;
        window-padding-x = 25;
        window-padding-y = 25;
        clipboard-read = "allow";
        clipboard-paste-protection = false;
        adjust-cell-height = 6;
        adjust-font-baseline = 1;
        background = "${base00}";
        foreground = "${base05}";
      };
      extraConfig = with config.colorScheme.colors; ''
        palette = 0=#${base00}
        palette = 8=#${base03}
        palette = 1=#${base0B}
        palette = 9=#${base0B}
        palette = 2=#${base0C}
        palette = 10=#${base0C}
        palette = 3=#${base0D}
        palette = 11=#${base0D}
        palette = 4=#${base07}
        palette = 12=#${base07}
        palette = 5=#${base0F}
        palette = 13=#${base0F}
        palette = 6=#${base09}
        palette = 14=#${base09}
        palette = 7=#${base04}
        palette = 15=#${base06}
      '';
      # keybindings = {
      #   "super+shift+c" = "text:\\x02\\x43";
      #   "super+e" = "text:\\x02\\x25";
      #   "super+shift+e" = "text:\\x02\\x22";
      #   "super+g" = "text:\\x02\\x67";
      #   "super+shift+g" = "text:\\x02\\x47";
      #   "super+j" = "text:\\x02\\x54";
      #   "super+k" = "text:\\x02\\x54";
      #   "super+l" = "text:\\x02\\x4c";
      #   "super+o" = "text:\\x02\\x75";
      #   "super+shift+v" = "text:\\x02\\x5d";
      #   "super+t" = "text:\\x02\\x63";
      #   "super+w" = "text:\\x02\\x78";
      #   "super+z" = "text:\\x02\\x7a";
      #   "super+comma" = "text:\\x02\\x2c";
      #   "super+one" = "text:\\x02\\x31";
      #   "super+two" = "text:\\x02\\x32";
      #   "super+three" = "text:\\x02\\x33";
      #   "super+four" = "text:\\x02\\x34";
      #   "super+five" = "text:\\x02\\x35";
      #   "super+six" = "text:\\x02\\x36";
      #   "super+seven" = "text:\\x02\\x37";
      #   "super+eight" = "text:\\x02\\x38";
      #   "super+nine" = "text:\\x02\\x39";
      # };
    };
  };
}
