{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) isDarwin isLinux;
in {
  imports = [./apps ./langs ./xdg.nix ./secrets/sops.nix ./theme];

  home = {
    packages = with pkgs; [
      trash-cli
      git-lfs
      just
      nix-your-shell
      atool
      ripgrep
      lazygit
      cmake
      spicetify-cli
      fd
      file
      minisign
      age
      hilbish
      git-crypt
      weechat
      pfetch-rs
      nur.repos.x0ba.lutgen
      nur.repos.x0ba.preview
      comma
      imagemagick
      chafa
      tmux-sessionizer
      fzf
      jq
      yt-dlp
      elinks
      glow
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
