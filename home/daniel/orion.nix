{...}: {
  # You can import other home-manager modules here
  imports = [
    ./global
    ./features/desktop/common
    ./features/term/alacritty.nix
    ./features/term/wezterm.nix
    ./features/music
    ./features/langs
    ./features/helix
  ];

  home = {
    mac-wallpaper = ./wallpapers/out.png;
    stateVersion = "23.05";
    username = "daniel";
  };
}
