{
  config,
  flakePath,
  ...
}: {
  xdg.configFile."sketchybar" = {
    source = config.lib.file.mkOutOfStoreSymlink "${flakePath}/home-manager/shared/programs/sketchybar/config";
    recursive = true;
  };
}
