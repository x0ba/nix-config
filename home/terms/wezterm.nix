{
  config,
  flakePath,
  lib,
  pkgs,
  ...
}: let
  mkSymlink = path: config.lib.file.mkOutOfStoreSymlink "${flakePath}/configs/wezterm/${path}";
in {
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
        "wezterm/wezterm.lua".source = mkSymlink "wezterm.lua";
        "wezterm/config" = {
          source = mkSymlink "config";
          recursive = true;
        };
        "wezterm/colors" = {
          source = mkSymlink "colors";
          recursive = true;
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
