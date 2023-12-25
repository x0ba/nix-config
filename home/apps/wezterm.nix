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
    "wezterm/catppuccin".source = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "wezterm";
      sha256 = "sha256-McSWoZaJeK+oqdK/0vjiRxZGuLBpEB10Zg4+7p5dIGY=";
      rev = "b1a81bae74d66eaae16457f2d8f151b5bd4fe5da";
    };
    "wezterm/rose-pine".source = pkgs.fetchFromGitHub {
      owner = "neapsix";
      repo = "wezterm";
      sha256 = "sha256-yKAdZa1NotM+w8q1u2N2oxxfBo3YcoS5ZdRr+retAB0=";
      rev = "8f14b2017478e8cdb65a54ade169680a9a45a51a";
    };
  };

  programs.zsh.initExtra = ''
    if [[ "$TERM_PROGRAM" == "WezTerm" ]]; then
      TERM=wezterm
      source ${config.programs.wezterm.package}/etc/profile.d/wezterm.sh
    fi
  '';
}
