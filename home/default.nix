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
      age
      gh
      restic
      atool
      xcp
      chafa
      curl
      comma
      deadnix
      elinks
      exiftool
      fd
      file
      pfetch-rs
      git-crypt
      git-lfs
      glow
      jq
      just
      nix-your-shell
      nur.repos.x0ba.lutgen
      nur.repos.x0ba.preview
      ripgrep
      sdcv
      sops
      tmux-sessionizer
      trash-cli
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
