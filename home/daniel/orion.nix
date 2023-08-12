{ ...
}: {
  # You can import other home-manager modules here
  imports = [
    ./global
    ./features/secrets
    ./features/desktop/common
    ./features/term/wezterm.nix
    ./features/productivity
    ./features/desktop/yabai
  ];

  home = {
    mac-wallpaper = ./wallpapers/leafy-moon.png;
    homeDirectory = "/Users/daniel";
    stateVersion = "23.05";
    username = "daniel";
  };
}
