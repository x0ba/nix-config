{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) isDarwin isLinux;
in {
  imports = [./apps ./langs ./xdg.nix ./secrets/sops.nix];

  home = {
    packages = with pkgs; [
      trash-cli
      git-lfs
      just
      nix-your-shell
      atool
      ripgrep
      cmake
      fd
      file
      minisign
      age
      git-crypt
      nur.repos.x0ba.lutgen
      nur.repos.x0ba.preview
      comma
      imagemagick
      chafa
      jq
      elinks
      glow
      fzf
      exiftool
      sdcv
      sqlite
      statix
      deadnix
    ];

    sessionVariables = lib.mkIf isDarwin {
      SSH_AUTH_SOCK = "${config.programs.gpg.homedir}/S.gpg-agent.ssh";
    };
    stateVersion = "23.05";
  };

  colorScheme = {
    slug = "gruvbox-material";
    name = "Gruvbox Material";
    author = "sainnhe";
    colors = {
      base00 = "292828";
      base01 = "32302f";
      base02 = "504945";
      base03 = "665c54";
      base04 = "bdae93";
      base05 = "ddc7a1";
      base06 = "ebdbb2";
      base07 = "fbf1c7";
      base08 = "ea6962";
      base09 = "e78a4e";
      base0A = "d8a657";
      base0B = "a9b665";
      base0C = "89b482";
      base0D = "7daea3";
      base0E = "d3869b";
      base0F = "bd6f3e";
    };
  };

  home.mac-wallpaper = ./wallpapers/solid-color-image.png;

  programs = {
    home-manager.enable = true;
    man.enable = true;
    taskwarrior.enable = true;
  };
  sops.secrets."wakatime-cfg".path = "${config.xdg.configHome}/wakatime/.wakatime.cfg";
}
