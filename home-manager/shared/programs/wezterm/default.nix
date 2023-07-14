{ config
, pkgs
, ...
}: {
  programs.wezterm = {
    enable = true;
  };
  # disable the default config created by Home-Manager
  xdg.configFile."wezterm/wezterm.lua".enable = false;
  # and use my own config instead
  xdg.configFile."wezterm" = {
    source = config.lib.file.mkOutOfStoreSymlink "/Users/daniel/Projects/dotfiles/config/wezterm";
    recursive = true;
  };

  programs.zsh.initExtra = ''
    if [[ "$TERM_PROGRAM" == "WezTerm" ]]; then
      source ${pkgs.wezterm}/etc/profile.d/wezterm.sh
    fi
  '';
}
