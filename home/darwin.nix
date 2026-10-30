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

  programs.ghostty = {
    enable = true;
    package = null;
    settings.theme = "Flexoki Dark";
  };
}
