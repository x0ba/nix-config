{ inputs
, outputs
, ...
}: {
  # You can import other home-manager modules here
  imports = [
    ./global
    ./features/desktop/yabai
    ./features/secrets
    ./features/desktop/common
    ./features/term/wezterm.nix
    ./features/productivity
  ];

  home = {
    mac-wallpaper = ./wallpapers/383838.png;
    homeDirectory = "/Users/daniel";
    stateVersion = "23.05";
    username = "daniel";
  };
}
