# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    outputs.homeManagerModules.mac-wallpaper

    ./global.nix

    ./secrets/sops.nix
    ./programs/cli
    ./programs/desktop/firefox
    ./programs/desktop/fonts.nix
    ./programs/editors/neovim.nix
    ./programs/term/wezterm.nix
  ];

  colorScheme = inputs.nix-colors.colorSchemes.mountain;

  disabledModules = ["targets/darwin/linkapps.nix"];
  home = {
    mac-wallpaper = ./wallpapers/background.jpg;
    activation = lib.mkIf pkgs.stdenv.isDarwin {
      copyApplications = let
        apps = pkgs.buildEnv {
          name = "home-manager-applications";
          paths = config.home.packages;
          pathsToLink = "/Applications";
        };
      in
        lib.hm.dag.entryAfter ["writeBoundary"] ''
          baseDir="$HOME/Applications/Home Manager Apps"
          if [ -d "$baseDir" ]; then
            rm -rf "$baseDir"
          fi
          mkdir -p "$baseDir"
          for appFile in ${apps}/Applications/*; do
            target="$baseDir/$(basename "$appFile")"
            $DRY_RUN_CMD cp ''${VERBOSE_ARG:+-v} -fHRL "$appFile" "$baseDir"
            $DRY_RUN_CMD chmod ''${VERBOSE_ARG:+-v} -R +w "$target"
          done
        '';
    };

    homeDirectory = "/Users/daniel";

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "23.05";
    username = "daniel";
  };

  sops.secrets."wakatime-cfg".path = "${config.xdg.configHome}/wakatime/.wakatime.cfg";
  sops.secrets."ssh-cfg".path = "${config.home.homeDirectory}/.ssh/config";

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
