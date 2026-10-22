{ ... }:
{
  programs.nushell = {
    enable = true;

    settings = {
      show_banner = false;
      highlight_resolved_externals = true;
    };

    extraConfig = ''
      # Homebrew setup
      if ('/opt/homebrew' | path type) == 'dir' {
        $env.HOMEBREW_PREFIX = '/opt/homebrew'
        $env.HOMEBREW_CELLAR = '/opt/homebrew/Cellar'
        $env.HOMEBREW_REPOSITORY = '/opt/homebrew'
        $env.PATH = $env.PATH? | prepend [
          '/opt/homebrew/bin'
          '/opt/homebrew/sbin'
        ]
        $env.MANPATH = $env.MANPATH? | prepend '/opt/homebrew/share/man'
        $env.INFOPATH = $env.INFOPATH? | prepend '/opt/homebrew/share/info'
      }
    '';
  };
}
