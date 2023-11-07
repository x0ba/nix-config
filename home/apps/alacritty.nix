{...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      window.padding.x = 45;
      window.padding.y = 45;
      window.decorations = "none";
      mouse.hide_when_typing = true;
      cursor.style = "Beam";
    };
  };
}
