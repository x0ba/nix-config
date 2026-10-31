{
  config,
  lib,
  repoOutOfStoreSymlink,
  ...
}:
{
  home.sessionVariables = {
    BROWSER = "open";
    CLICOLOR = "1";
  };

  # Tools not packaged in nixpkgs; they install and update themselves.
  home.sessionPath = [ "$HOME/.grok/bin" "$HOME/.opencode/bin" ];

  # Fish turns this on for apropos. On Darwin with stateVersion >= 26.05
  # the man package stays null, because nixpkgs man-db's apropos and whatis
  # do not work there, so the option only warns.
  programs.man.generateCaches = false;

  programs.ghostty = {
    enable = true;
    package = null;
    settings.theme = "Flexoki Dark";
  };
}
