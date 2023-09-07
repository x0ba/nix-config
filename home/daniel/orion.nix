{ ... }: {
  # You can import other home-manager modules here
  imports = [
    ./global
    ./features/desktop/common
    ./features/term/alacritty.nix
    ./features/term/wezterm.nix
    ./features/pass
    ./features/desktop/yabai
    ./features/music
    ./features/langs
    ./features/helix
  ];

  home = {
    mac-wallpaper = ./wallpapers/171b20.png;
    homeDirectory = "/Users/daniel";
    stateVersion = "23.05";
    username = "daniel";
  };
}
