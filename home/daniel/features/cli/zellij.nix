{pkgs, config, flakePath, ...}:
{
  programs.zellij.enable = true;
  xdg.configFile."zellij" = {
    source = config.lib.file.mkOutOfStoreSymlink "${flakePath}/config/zellij";
    recursive = true;
  };
}

