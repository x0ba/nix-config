{...}: {
  programs.ghostty = {
    enable = true;
    shellIntegration.enable = true;
    settings = {
      font-family = "Liga Berkeley Mono";
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
      adjust-cell-height = 6;
      adjust-font-baseline = 3;
      clipboard-read = "allow";
      clipboard-paste-protection = false;
      font-feature = ["zero" "ss01" "ss02" "ss03" "ss04" "ss05" "ss06" "calt" "liga"];
      theme = "catppuccin-mocha";
    };
  };
}
