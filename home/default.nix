{
  config,
  lib,
  pkgs,
  osConfig,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) isDarwin;
in {
  imports = [./xdg.nix ./apps.nix ./theme.nix];

  home = {
    packages = with pkgs; [
      comma
      fd
      git-lfs
      gocryptfs
      just
      lazygit
      nix-output-monitor
      nvd
      ripgrep
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
