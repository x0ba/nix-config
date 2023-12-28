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
      age
      atool
      chafa
      comma
      deadnix
      exiftool
      fd
      file
      gh
      git-crypt
      git-lfs
      glow
      gocryptfs
      just
      nix-output-monitor
      nur.repos.x0ba.lutgen
      nur.repos.x0ba.preview
      nvd
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
