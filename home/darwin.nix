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
  home.sessionPath = [ "$HOME/.grok/bin" ];
  # Vite+ must go on PATH before direnv-instant starts. direnv-instant saves
  # the PATH it sees and puts it back at every prompt, which would drop vp.
  programs.zsh.initContent = lib.mkMerge [
    (lib.mkBefore ''
      [ -f ~/.config/vite-plus/env ] && . ~/.config/vite-plus/env
    '')
    ''
      fpath=(~/.grok/completions/zsh $fpath)
    ''
  ];
  programs.fish.interactiveShellInit = lib.mkBefore ''
    test -f ~/.config/vite-plus/env.fish; and source ~/.config/vite-plus/env.fish
  '';

  # OrbStack (Homebrew cask) adds its CLI and completions here.
  programs.zsh.profileExtra = ''
    source ~/.orbstack/shell/init.zsh 2>/dev/null || :
  '';
  programs.fish.loginShellInit = ''
    source ~/.orbstack/shell/init2.fish 2>/dev/null || :
  '';

  programs.ghostty = {
    enable = true;
    package = null;
    settings.theme = "Flexoki Dark";
  };
}
