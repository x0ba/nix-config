{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) isDarwin;
in {
  imports = [./apps ./xdg.nix ./secrets/sops.nix];

  home = {
    packages = with pkgs; [
      _1password
      age
      age-plugin-yubikey
      comma
      fd
      ffmpeg
      file
      gh
      gh-dash
      git-crypt
      git-lfs
      glow
      gocryptfs
      imagemagick
      just
      lazygit
      lutgen
      mosh
      yq
      nix-output-monitor
      gitmux
      nur.repos.x0ba.icat
      nvd
      ranger
      ripgrep
      sops
      trash-cli
      wakatime
      watchexec
    ];

    sessionVariables = lib.mkIf isDarwin {
      SSH_AUTH_SOCK = "${config.programs.gpg.homedir}/S.gpg-agent.ssh";
    };
    stateVersion = "23.05";
  };

  colorScheme = {
    slug = "oxocarbon";
    name = "Oxocarbon";
    author = "Nyoom Engineering";
    colors = {
      base00 = "161616";
      base01 = "262626";
      base02 = "393939";
      base03 = "525252";
      base04 = "dde1e6";
      base05 = "f2f4f8";
      base06 = "ffffff";
      base07 = "08bdba";
      base08 = "3ddbd9";
      base09 = "78a9ff";
      base0A = "ee5396";
      base0B = "33b1ff";
      base0C = "ff7eb6";
      base0D = "42be65";
      base0E = "be95ff";
      base0F = "82cfff";
    };
  };

  programs = {
    home-manager.enable = true;
    man.enable = true;
    taskwarrior.enable = true;
  };

  sops.secrets."sshconfig".path = "${config.home.homeDirectory}/.ssh/config";
  sops.secrets."wakatime-cfg".path = "${config.xdg.configHome}/wakatime/.wakatime.cfg";
}
