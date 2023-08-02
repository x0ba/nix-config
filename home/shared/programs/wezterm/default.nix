{
  config,
  flakePath,
  ...
}: {
  programs.wezterm = {
    enable = true;
    # package = pkgs.wezterm;
  };
  # disable the default config created by Home-Manager
  xdg.configFile."wezterm/wezterm.lua".enable = false;
  # and use my own config instead
  xdg.configFile."wezterm" = {
    source = ./config;
    recursive = true;
  };
  programs.zsh.initExtra = ''
    if [[ "$TERM_PROGRAM" == "WezTerm" ]]; then
      TERM=wezterm
      source ${config.programs.wezterm.package}/etc/profile.d/wezterm.sh
    fi
  '';
}
