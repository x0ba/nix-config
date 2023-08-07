{
  inputs,
  outputs,
  config,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    outputs.homeManagerModules.mac-wallpaper
    ./global.nix
    ./secrets/sops.nix
    ./programs/cli
    ./programs/desktop/firefox.nix
    ./programs/desktop/fonts.nix
    ./programs/editors/neovim.nix
    ./programs/term/wezterm.nix
  ];

  colorScheme = inputs.nix-colors.colorSchemes.mountain;

  home = {
    mac-wallpaper = ./wallpapers/background.jpg;
    homeDirectory = "/Users/daniel";
    stateVersion = "23.05";
    username = "daniel";
  };

  sops.secrets."wakatime-cfg".path = "${config.xdg.configHome}/wakatime/.wakatime.cfg";
  sops.secrets."ssh-cfg".path = "${config.home.homeDirectory}/.ssh/config";

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
