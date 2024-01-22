{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) isDarwin;
in {
  imports = [./xdg.nix ./apps.nix];

  home = {
    packages = with pkgs; [
      comma
      fd
      git-lfs
      gocryptfs
      just
      lazygit
      nix-output-monitor
      nixfmt
      nvd
      ripgrep
      trash-cli
      xcp
    ];

    sessionVariables = lib.mkIf isDarwin {
      SSH_AUTH_SOCK = "${config.programs.gpg.homedir}/S.gpg-agent.ssh";
    };
    stateVersion = "23.05";
  };

  colorScheme = {
    slug = "oxocarbon";
    name = "Oxocarbon Dark";
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
  xdg.configFile = {
    "karabiner/karabiner.json" = {
      source = ../configs/karabiner/karabiner.json;
    };
  };
}
