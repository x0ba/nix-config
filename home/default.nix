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
    slug = "tokyonight-night";
    name = "Tokyonight Night";
    author = "folke";
    colors = {
      base00 = "1A1B26";
      base01 = "232433";
      base02 = "2A2B3D";
      base03 = "32344A";
      base04 = "3B3D57";
      base05 = "A9B1D6";
      base06 = "A9B1D6";
      base07 = "A9B1D6";
      base08 = "F7768E";
      base09 = "FF9E64";
      base0A = "E0AF68";
      base0B = "9ECE6A";
      base0C = "7DCFFF";
      base0D = "7AA2F7";
      base0E = "AD8EE6";
      base0F = "E0AF68";
    };
  };

  home.mac-wallpaper = ./wallpapers/tokyoleaf.png;

  programs = {
    home-manager.enable = true;
    man.enable = true;
    taskwarrior.enable = true;
  };

  sops.secrets."wakatime-cfg".path = "${config.xdg.configHome}/wakatime/.wakatime.cfg";
}
