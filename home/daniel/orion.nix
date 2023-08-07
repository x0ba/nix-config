{ inputs
, outputs
, config
, ...
}: {
  # You can import other home-manager modules here
  imports = [
    outputs.homeManagerModules.mac-wallpaper
    ./global
    ./features/secrets
    ./features/cli
    ./features/desktop/common
    ./features/neovim
    ./features/term/wezterm.nix
    ./features/productivity
  ];

  colorScheme = inputs.nix-colors.colorSchemes.mountain;

  home = {
    mac-wallpaper = ./wallpapers/background.jpg;
    homeDirectory = "/Users/daniel";
    stateVersion = "23.05";
    username = "daniel";
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
