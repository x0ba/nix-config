{ lib, config, ... }:
{

  options = {
    ghostty.enable = lib.mkEnableOption "enables ghostty";
  };

  config = lib.mkIf config.ghostty.enable {
    programs.ghostty = {
      enable = true;

      settings = {
        font-family = "Berkeley Mono";
        font-size = 13;

        theme = "catppuccin-mocha";
        cursor-style = "bar";

        window-theme = "dark";
        term = "xterm-ghostty";
        macos-titlebar-style = "tabs";
        window-save-state = "never";
        window-padding-x = 10;
        window-height = 30;
        window-width = 120;
      };
    };
  };
}
