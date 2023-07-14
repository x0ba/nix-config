{ inputs, outputs, lib, config, pkgs, flakePath, ... }:
{
  xdg.configFile."sketchybar" = {
    source = config.lib.file.mkOutOfStoreSymlink "${flakePath}/config/sketchybar";
    recursive = true;
  };
}
