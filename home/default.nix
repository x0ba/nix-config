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
      minisign
      age
      git-crypt
      pfetch-rs
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
    slug = "mountain";
    name = "Mountain";
    colors = {
      base00 = "0f0f0f";
      base01 = "191919";
      base02 = "262626";
      base03 = "4c4c4c";
      base04 = "ac8a8c";
      base05 = "cacaca";
      base06 = "e7e7e7";
      base07 = "f0f0f0";
      base08 = "ac8a8c";
      base09 = "ceb188";
      base0A = "aca98a";
      base0B = "8aac8b";
      base0C = "8aabac";
      base0D = "8f8aac";
      base0E = "ac8aac";
      base0F = "ac8a8c";
    };
  };

  # home.mac-wallpaper = ./wallpapers/bg.png;

  programs = {
    home-manager.enable = true;
    man.enable = true;
    taskwarrior.enable = true;
  };
  sops.secrets."wakatime-cfg".path = "${config.xdg.configHome}/wakatime/.wakatime.cfg";

  disabledModules = ["targets/darwin/linkapps.nix"];
  home.activation = lib.mkIf pkgs.stdenv.isDarwin {
    copyApplications = let
      apps = pkgs.buildEnv {
        name = "home-manager-applications";
        paths = config.home.packages;
        pathsToLink = "/Applications";
      };
    in
      lib.hm.dag.entryAfter ["writeBoundary"] ''
        baseDir="$HOME/Applications/Home Manager Apps"
        if [ -d "$baseDir" ]; then
          rm -rf "$baseDir"
        fi
        mkdir -p "$baseDir"
        for appFile in ${apps}/Applications/*; do
          target="$baseDir/$(basename "$appFile")"
          $DRY_RUN_CMD cp ''${VERBOSE_ARG:+-v} -fHRL "$appFile" "$baseDir"
          $DRY_RUN_CMD chmod ''${VERBOSE_ARG:+-v} -R +w "$target"
        done
      '';
  };
}
