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
    slug = "darkppuccin";
    name = "Darkppuccin";
    author = "x0ba";
    colors = {
      base00 = "131a1c"; # base
      base01 = "192022"; # mantle
      base02 = "202729"; # surface0
      base03 = "363d3e"; # surface1
      base04 = "4a5051"; # surface2
      base05 = "c5c8c9"; # text
      base06 = "f4dbd6"; # rosewater
      base07 = "b7bdf8"; # lavender
      base08 = "ed8796"; # red
      base09 = "f5a97f"; # peach
      base0A = "eed49f"; # yellow
      base0B = "a6da95"; # green
      base0C = "8bd5ca"; # teal
      base0D = "8aadf4"; # blue
      base0E = "c6a0f6"; # mauve
      base0F = "f0c6c6"; # flamingo
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
