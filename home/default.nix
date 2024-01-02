{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) isDarwin isLinux;
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
      git-crypt
      git-lfs
      glow
      gocryptfs
      imagemagick
      just
      lutgen
      nix-output-monitor
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

  programs = {
    home-manager.enable = true;
    man.enable = true;
    taskwarrior.enable = true;
  };

  sops.secrets."sshconfig".path = "${config.home.homeDirectory}/.ssh/config";
  sops.secrets."wakatime-cfg".path = "${config.xdg.configHome}/wakatime/.wakatime.cfg";
}
