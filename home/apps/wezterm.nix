{
  config,
  flakePath,
  pkgs,
  ...
}: let
  mkSymlink = path: config.lib.file.mkOutOfStoreSymlink "${flakePath}/home/apps/wezterm/${path}";
in {
  programs.wezterm.enable = true;

  xdg.configFile = {
    "wezterm/wezterm.lua".source = mkSymlink "wezterm.lua";
    "wezterm/config" = {
      source = mkSymlink "config";
      recursive = true;
    };
    "wezterm/bar".source = pkgs.fetchFromGitHub {
      owner = "nekowinston";
      repo = "wezterm-bar";
      sha256 = "sha256-3acxqJ9HMA5hASWq/sVL9QQjfEw5Xrh2fT9nFuGjzHM=";
      rev = "e96b81460b3ad11a7461934dcb7889ce5079f97f";
    };
    "wezterm/rose-pine".source = pkgs.fetchFromGitHub {
      owner = "x0ba";
      repo = "rose-pine-wezterm";
      sha256 = "sha256-XlOoOQXmKi8C6RRMkn+nP+L4Qie0XlM9jkWy6BQOoyg=";
      rev = "31049a80e1feb3008d992840f59749ed296c7568";
    };
  };

  programs.zsh.initExtra = ''
    if [[ "$TERM_PROGRAM" == "WezTerm" ]]; then
      TERM=wezterm
      source ${config.programs.wezterm.package}/etc/profile.d/wezterm.sh
    fi
  '';
}
