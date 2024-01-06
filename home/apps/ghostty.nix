{ config
, lib
, ...
}: {
  config = lib.mkIf config.isGraphical {
    programs.ghostty = {
      enable = true;
      settings = {
        font-family = "Cartograph CF";
        window-decoration = false;
        window-inherit-working-directory = true;
        unfocused-split-opacity = 0.96;
        font-size = 15;
        window-theme = "dark";
        confirm-close-surface = false;
        macos-option-as-alt = true;
        mouse-hide-while-typing = true;
        cursor-style = "bar";
        cursor-style-blink = true;
        window-padding-x = 10;
        window-padding-y = 10;
        clipboard-read = "allow";
        clipboard-paste-protection = false;
        font-feature = [ "zero" "calt" "liga" ];
        theme = "catppuccin-frappe";
      };
    };
  };
}
