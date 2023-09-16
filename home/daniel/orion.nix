{...}: {
  # You can import other home-manager modules here
  imports = [
    ./global
    ./features/desktop/common
    ./features/term/wezterm.nix
    ./features/langs
  ];

  home = {
    mac-wallpaper = ./wallpapers/oxo.png;
    stateVersion = "23.05";
    username = "daniel";
  };
}
