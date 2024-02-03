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
      trash-cli
      xcp
    ];

    sessionVariables = lib.mkIf isDarwin {
      SSH_AUTH_SOCK = "${config.programs.gpg.homedir}/S.gpg-agent.ssh";
    };
    stateVersion = "23.05";
  };

  # symlinks don't work with finder + spotlight, copy them instead
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

  colorScheme = {
    slug = "gruvbox-dark-medium";
    name = "Gruvbox Dark Medium";
    palette = {
      base00 = "282828"; # ----
      base01 = "3c3836"; # ---
      base02 = "504945"; # --
      base03 = "665c54"; # -
      base04 = "bdae93"; # +
      base05 = "d5c4a1"; # ++
      base06 = "ebdbb2"; # +++
      base07 = "fbf1c7"; # ++++
      base08 = "fb4934"; # red
      base09 = "fe8019"; # orange
      base0A = "fabd2f"; # yellow
      base0B = "b8bb26"; # green
      base0C = "8ec07c"; # aqua/cyan
      base0D = "83a598"; # blue
      base0E = "d3869b"; # purple
      base0F = "d65d0e"; # brown
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
