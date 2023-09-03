{ ... }: {
  # You can import other home-manager modules here
  imports = [
    ./global
    ./features/desktop/common
    ./features/term/alacritty.nix
    ./features/pass
    ./features/desktop/yabai
    ./features/music
    ./features/langs
    ./features/helix
  ];

  home = {
    mac-wallpaper = ./wallpapers/space.jpg;
    homeDirectory = "/Users/daniel";
    stateVersion = "23.05";
    username = "daniel";
  };
}
