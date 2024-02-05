{
  config,
  lib,
  pkgs,
  ...
}: {
  # use the GUI version & config when we have a gui, else just get terminfo
  config = lib.mkMerge [
    (lib.mkIf (!config.isGraphical) {
      home.packages = [pkgs.wezterm.terminfo];
    })

    (lib.mkIf config.isGraphical {
      programs.wezterm = {
        enable = true;
        package = pkgs.nur.repos.x0ba.wezterm-nightly;
      };

      xdg.configFile = {
        "wezterm/wezterm.lua".source = ../../configs/wezterm/wezterm.lua;
        "wezterm/config" = {
          source = ../../configs/wezterm/config;
          recursive = true;
        };
        "wezterm/bar".source = pkgs.fetchFromGitHub {
          owner = "nekowinston";
          repo = "wezterm-bar";
          sha256 = "sha256-3acxqJ9HMA5hASWq/sVL9QQjfEw5Xrh2fT9nFuGjzHM=";
          rev = "e96b81460b3ad11a7461934dcb7889ce5079f97f";
        };
      };

      programs.zsh.initExtra = ''
        if [[ "$TERM_PROGRAM" == "WezTerm" ]]; then
          TERM=wezterm
          source ${config.programs.wezterm.package}/etc/profile.d/wezterm.sh
        fi
      '';
    })
  ];
}
