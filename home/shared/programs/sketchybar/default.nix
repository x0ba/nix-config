{
  config,
  flakePath,
  ...
}: {
  xdg.configFile."sketchybar" = {
    source = config.lib.file.mkOutOfStoreSymlink "${flakePath}/home/shared/programs/sketchybar/config";
    recursive = true;
  };
}
