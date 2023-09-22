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
    slug = "catppuccin";
    name = "Catppuccin Mocha";
    author = "catppuccin";
    colors = {
      base00 = "1e1e2e";
      base01 = "181825";
      base02 = "313244";
      base03 = "45475a";
      base04 = "585b70";
      base05 = "cdd6f4";
      base06 = "f5e0dc";
      base07 = "b4befe";
      base08 = "f38ba8";
      base09 = "fab387";
      base0A = "f9e2af";
      base0B = "a6e3a1";
      base0C = "94e2d5";
      base0D = "89b4fa";
      base0E = "cba6f7";
      base0F = "f2cdcd";
    };
  };

  home.mac-wallpaper = ./wallpapers/Night.png;

  programs = {
    home-manager.enable = true;
    man.enable = true;
    taskwarrior.enable = true;
  };

  sops.secrets."wakatime-cfg".path = "${config.xdg.configHome}/wakatime/.wakatime.cfg";
}
