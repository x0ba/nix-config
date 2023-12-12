{...}: {
  programs.ghostty = {
    enable = true;
    settings = {
      font-family = "Liga Berkeley Mono";
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
      adjust-cell-height = 6;
      adjust-font-baseline = 3;
      clipboard-read = "allow";
      clipboard-paste-protection = false;
      font-feature = ["zero" "calt" "liga"];
      theme = "catppuccin-mocha";
    };
  };
}
