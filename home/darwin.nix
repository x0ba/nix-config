{ config, repoOutOfStoreSymlink, ... }:
{
  home.sessionVariables = {
    BROWSER = "open";
    CLICOLOR = "1";
  };

  # Tools not packaged in nixpkgs; they install and update themselves.
  home.sessionPath = [ "$HOME/.grok/bin" ];
  programs.zsh.initContent = ''
    fpath=(~/.grok/completions/zsh $fpath)
    [ -f ~/.config/vite-plus/env ] && . ~/.config/vite-plus/env
  '';
  programs.fish.interactiveShellInit = ''
    test -f ~/.config/vite-plus/env.fish; and source ~/.config/vite-plus/env.fish
  '';

  # OrbStack (Homebrew cask) adds its CLI and completions here.
  programs.zsh.profileExtra = ''
    source ~/.orbstack/shell/init.zsh 2>/dev/null || :
  '';

  # Ghostty itself comes from the Homebrew cask; Nix only writes the config.
  programs.ghostty = {
    enable = true;
    package = null;
    settings.theme = "Flexoki Dark";
  };
}
