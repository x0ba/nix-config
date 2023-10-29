{
  lib,
  config,
  ...
}: {
  programs.alacritty = {
    enable = true;
    settings = with config.lib.stylix.colors; {
      window.padding.x = 45;
      window.padding.y = 45;
      window.decorations = "none";
      mouse.hide_when_typing = true;
      cursor.style = "Beam";
    };
  };
}
