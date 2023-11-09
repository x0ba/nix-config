{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) isDarwin;
in {
  imports = [./apps ./xdg.nix ./secrets/sops.nix ./theme];

  home = {
    packages = with pkgs; [
      trash-cli
      taskwarrior-tui
      git-lfs
      just
      nix-your-shell
      atool
      ripgrep
      fd
      file
      age
      git-crypt
      nur.repos.x0ba.lutgen
      nur.repos.x0ba.preview
      comma
      chafa
      tmux-sessionizer
      jq
      yt-dlp
      elinks
      sops
      glow
      exiftool
      sdcv
      statix
      deadnix
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
}
