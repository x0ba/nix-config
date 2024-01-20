{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.isGraphical {
    programs.ghostty = {
      enable = true;
      settings = with config.colorScheme.colors; {
        font-family = "Fira Code";
        font-feature = "ss14";
        theme = "catppuccin-macchiato";
        window-decoration = false;
        window-inherit-working-directory = true;
        unfocused-split-opacity = 0.96;
        font-size = 16;
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
        palette = "8=#363d3e";
      };
      extraConfig = with config.colorScheme.colors; ''
      '';
      keybindings = {
        "super+shift+c" = "text:\\x02\\x43";
        "super+e" = "text:\\x02\\x25";
        "super+shift+e" = "text:\\x02\\x22";
        "super+g" = "text:\\x02\\x67";
        "super+shift+g" = "text:\\x02\\x47";
        "super+j" = "text:\\x02\\x54";
        "super+k" = "text:\\x02\\x54";
        "super+l" = "text:\\x02\\x4c";
        "super+o" = "text:\\x02\\x75";
        "super+shift+v" = "text:\\x02\\x5d";
        "super+t" = "text:\\x02\\x63";
        "super+w" = "text:\\x02\\x78";
        "super+z" = "text:\\x02\\x7a";
        "super+comma" = "text:\\x02\\x2c";
        "super+one" = "text:\\x02\\x31";
        "super+two" = "text:\\x02\\x32";
        "super+three" = "text:\\x02\\x33";
        "super+four" = "text:\\x02\\x34";
        "super+five" = "text:\\x02\\x35";
        "super+six" = "text:\\x02\\x36";
        "super+seven" = "text:\\x02\\x37";
        "super+eight" = "text:\\x02\\x38";
        "super+nine" = "text:\\x02\\x39";
      };
    };
  };
}
