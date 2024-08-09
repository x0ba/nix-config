{ lib, config, ... }:
{

  options = {
    ghostty.enable = lib.mkEnableOption "enables ghostty";
  };

  config = lib.mkIf config.ghostty.enable {
    programs.ghostty = {
      enable = true;

      settings = {
        mouse-hide-while-typing = true;
        unfocused-split-opacity = 0.8;

        quit-after-last-window-closed = true;
        macos-titlebar-style = "tabs";
        window-save-state = "never";

        # window-padding-color = "extend";

        macos-option-as-alt = true;

        font-family = "Berkeley Mono";
        font-size = 13;

        theme = "catppuccin-mocha";

        window-padding-x = 10;
        window-height = 30;
        window-width = 120;
      };

      keybindings = {
        "super+left" = "goto_split:left";
        "super+right" = "goto_split:right";
        "super+up" = "goto_split:top";
        "super+down" = "goto_split:bottom";

        "super+control+left" = "resize_split:left,40";
        "super+control+right" = "resize_split:right,40";
        "super+control+up" = "resize_split:up,40";
        "super+control+down" = "resize_split:down,40";

        "page_up" = "scroll_page_fractional:-0.5";
        "page_down" = "scroll_page_fractional:0.5";
      };
    };
  };
}
