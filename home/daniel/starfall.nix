# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    ./global.nix
    ./features/cli
    ./features/desktop/sway
    ./features/desktop/common
    ./features/term/foot.nix
    ./features/desktop/launchers/rofi.nix
    ./features/editors/neovim.nix
  ];

  colorScheme = inputs.nix-colors.colorSchemes.tomorrow-night;

  fonts.fontconfig.enable = true;

  home = {
    homeDirectory = "/home/daniel";

    packages = lib.attrValues {
      inherit
        (pkgs)
        playerctl
        trash-cli
        xdg-user-dirs
        paper-icon-theme
        vscode
        font-manager
        transmission-gtk
        ;
    };

    sessionPath = [
      "${config.home.homeDirectory}/.local/bin"
    ];

    sessionVariables = {
      BROWSER = "${pkgs.firefox}/bin/firefox";
      EDITOR = "${pkgs.neovim}/bin/nvim";
      RUSTUP_HOME = "${config.home.homeDirectory}/.local/share/rustup";
      XDG_CONFIG_HOME = "${config.home.homeDirectory}/.config";
      XDG_DATA_HOME = "${config.home.homeDirectory}/.local/share";
    };

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "23.05";
    username = "daniel";
  };

  services = {
    gpg-agent = {
      enable = true;
      defaultCacheTtl = 1800;
      enableSshSupport = true;
    };

    playerctld.enable = true;
  };

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      documents = "${config.home.homeDirectory}/Documents";
      music = "${config.home.homeDirectory}/Music";
      pictures = "${config.home.homeDirectory}/Pictures";
      videos = "${config.home.homeDirectory}/Videos";
    };
  };
}
